#!/bin/bash

set -e

# -----------------------------
# 1. CONFIG
# -----------------------------
JENKINS_USER="admin"
JENKINS_PASS="admin123"
TOKEN_NAME="automation-token"
LATEST_JENKINS_URL="https://pkg.jenkins.io/debian/binary/jenkins_2.532_all.deb"

echo "================================================"
echo "Starting Jenkins Setup..."
echo "================================================"

# -----------------------------
# 2. INSTALL JAVA + TOOLS
# -----------------------------
echo "Installing Java and required tools..."

sudo apt-get update -y
sudo apt-get install -y fontconfig openjdk-21-jre jq curl wget

echo "Java and tools installation completed"

# -----------------------------
# TMP FIX
# -----------------------------
echo "Configuring /tmp space..."

echo 'tmpfs /tmp tmpfs defaults,noatime,mode=1777,size=2G 0 0' | sudo tee -a /etc/fstab

sudo mount -o remount /tmp

df -h /tmp

echo "/tmp configured successfully"

# -----------------------------
# 3. INSTALL JENKINS
# -----------------------------
echo "Downloading Jenkins package..."

wget -q $LATEST_JENKINS_URL -O /tmp/jenkins.deb

echo "Installing Jenkins..."

sudo dpkg -i /tmp/jenkins.deb || sudo apt-get install -f -y

sudo systemctl stop jenkins

echo "Jenkins installation completed"

# -----------------------------
# 4. INSTALL PLUGINS
# -----------------------------
echo "Installing Jenkins plugins..."

sudo mkdir -p /var/lib/jenkins/plugins

cat <<EOF > /tmp/plugins.txt
workflow-aggregator
workflow-multibranch
pipeline-stage-view
pipeline-model-definition
git
github
docker-workflow
kubernetes
aws-credentials
blueocean
nodejs
maven-plugin
email-ext
junit
slack
EOF

wget -q -O /tmp/plugin-manager.jar \
https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.13.0/jenkins-plugin-manager-2.13.0.jar

sudo java -jar /tmp/plugin-manager.jar \
--plugin-file /tmp/plugins.txt \
--plugin-download-directory /var/lib/jenkins/plugins \
--war /usr/share/java/jenkins.war

sudo chown -R jenkins:jenkins /var/lib/jenkins/plugins

echo "Plugins installation completed"

# -----------------------------
# 5. DISABLE SETUP WIZARD
# -----------------------------
echo "Disabling Jenkins setup wizard..."

echo "2.0" | sudo tee /var/lib/jenkins/jenkins.install.UpgradeWizard.state

sudo mkdir -p /etc/systemd/system/jenkins.service.d

echo -e "[Service]\nEnvironment=\"JAVA_OPTS=-Djenkins.install.runSetupWizard=false\"" \
| sudo tee /etc/systemd/system/jenkins.service.d/override.conf

echo "Setup wizard disabled"

# -----------------------------
# 6. CREATE ADMIN USER
# -----------------------------
echo "Creating Jenkins admin user..."

sudo mkdir -p /var/lib/jenkins/init.groovy.d

cat <<EOF | sudo tee /var/lib/jenkins/init.groovy.d/basic-security.groovy
import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("$JENKINS_USER", "$JENKINS_PASS")

instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)

instance.setAuthorizationStrategy(strategy)

instance.save()
EOF

echo "Admin user created"

# -----------------------------
# 7. DISABLE DISK SPACE MONITOR
# -----------------------------
echo "Disabling disk space monitor..."

cat <<EOF | sudo tee /var/lib/jenkins/init.groovy.d/disable-monitor.groovy
import jenkins.model.*
import hudson.node_monitors.*

Jenkins.instance.nodeMonitors.each {
  if (it instanceof DiskSpaceMonitorDescriptor) {
    Jenkins.instance.nodeMonitors.remove(it)
  }
}

Jenkins.instance.save()
EOF

sudo chown -R jenkins:jenkins /var/lib/jenkins/

echo "Disk space monitor disabled"

# -----------------------------
# 8. START JENKINS
# -----------------------------
echo "Starting Jenkins service..."

sudo systemctl daemon-reload
sudo systemctl restart jenkins

echo "Waiting for Jenkins to start..."

until curl -s http://localhost:8080/login >/dev/null
do
  sleep 5
done

echo "Jenkins started successfully"

# -----------------------------
# 9. DOWNLOAD CLI + AGENT
# -----------------------------
echo "Downloading Jenkins CLI and agent..."

cd /tmp

wget -q http://localhost:8080/jnlpJars/jenkins-cli.jar
wget -q http://localhost:8080/jnlpJars/agent.jar

echo "CLI and agent downloaded"

# -----------------------------
# 10. GENERATE API TOKEN
# -----------------------------
echo "Generating Jenkins API token..."

cat <<EOF > /tmp/gen-token.groovy
import jenkins.model.*
import hudson.model.*
import jenkins.security.*

def user = User.get('$JENKINS_USER')
def prop = user.getProperty(ApiTokenProperty.class)

def token = prop.tokenStore.generateNewToken('$TOKEN_NAME')

user.save()

println(token.plainValue)
EOF

API_TOKEN=$(java -jar /tmp/jenkins-cli.jar \
-s http://localhost:8080 \
-auth $JENKINS_USER:$JENKINS_PASS \
groovy = < /tmp/gen-token.groovy)

echo "API token generated successfully"

# -----------------------------
# 11. GET PUBLIC IP
# -----------------------------
echo "Fetching public IP..."

PUBLIC_IP=$(curl -s ifconfig.me)

JENKINS_URL="http://$PUBLIC_IP:8080"

echo "------------------------------------------------"
echo "JENKINS URL : $JENKINS_URL"
echo "USERNAME    : $JENKINS_USER"
echo "PASSWORD    : $JENKINS_PASS"
echo "API TOKEN   : $API_TOKEN"
echo "------------------------------------------------"

# -----------------------------
# 12. UPDATE JENKINS URL
# -----------------------------
echo "Updating Jenkins URL..."

sleep 20

sudo mkdir -p /var/lib/jenkins

JENKINS_CONFIG="/var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml"

if [ ! -f "$JENKINS_CONFIG" ]; then

sudo tee $JENKINS_CONFIG > /dev/null <<EOF
<?xml version='1.1' encoding='UTF-8'?>
<jenkins.model.JenkinsLocationConfiguration>
  <adminAddress>address not configured yet &lt;nobody@nowhere&gt;</adminAddress>
  <jenkinsUrl>$JENKINS_URL/</jenkinsUrl>
</jenkins.model.JenkinsLocationConfiguration>
EOF

else

sudo sed -i \
"s|<jenkinsUrl>.*</jenkinsUrl>|<jenkinsUrl>$JENKINS_URL/</jenkinsUrl>|g" \
$JENKINS_CONFIG

fi

sudo chown jenkins:jenkins $JENKINS_CONFIG

sudo systemctl restart jenkins

echo "Jenkins URL Updated Successfully"

sleep 10

# -----------------------------
# 13. CREATE DEFAULT NODES
# -----------------------------
echo "================================================"
echo "Creating default Jenkins nodes..."
echo "================================================"

NODES=("agent1" "agent2" "agent3")

EXECUTORS=2

for NAME in "${NODES[@]}"
do

echo "------------------------------------------------"
echo "Creating node : $NAME"
echo "------------------------------------------------"

echo "Executors for $NAME : $EXECUTORS"

cat > /tmp/node.xml <<EOF
<slave>

  <name>$NAME</name>

  <remoteFS>/home/ubuntu/$NAME</remoteFS>

  <numExecutors>$EXECUTORS</numExecutors>

  <mode>NORMAL</mode>

  <retentionStrategy class="hudson.slaves.RetentionStrategy\$Always"/>

  <launcher class="hudson.slaves.JNLPLauncher">

    <workDirSettings>
      <disabled>false</disabled>
      <internalDir>remoting</internalDir>
      <failIfWorkDirIsMissing>false</failIfWorkDirIsMissing>
    </workDirSettings>

    <webSocket>true</webSocket>

  </launcher>

  <label></label>

  <nodeProperties>
    <hudson.slaves.EnvironmentVariablesNodeProperty>
      <env>
        <entry>
          <string>JAVA_HOME</string>
          <string>/usr/lib/jvm/java-21-openjdk-amd64</string>
        </entry>
      </env>
    </hudson.slaves.EnvironmentVariablesNodeProperty>
  </nodeProperties>

</slave>
EOF

# ✅ YOUR ADDED PART (SAFE DELETE)
java -jar /tmp/jenkins-cli.jar \
-s http://localhost:8080 \
-auth $JENKINS_USER:$API_TOKEN \
delete-node $NAME >/dev/null 2>&1 || true

echo "Old node removed (if existed): $NAME"


# CREATE NODE
java -jar /tmp/jenkins-cli.jar \
-s http://localhost:8080 \
-auth $JENKINS_USER:$API_TOKEN \
create-node $NAME < /tmp/node.xml

echo "Node created successfully : $NAME"

# GET SECRET
echo "Fetching secret for $NAME..."

SECRET=$(curl -s -u $JENKINS_USER:$API_TOKEN \
http://localhost:8080/computer/$NAME/slave-agent.jnlp \
| grep -oP '(?<=<application-desc><argument>).*?(?=</argument>)' \
| head -1)

echo "Secret fetched successfully"

# CREATE WORKSPACE
mkdir -p /home/ubuntu/$NAME

echo "Workspace created for $NAME"

# START AGENT
echo "Starting Jenkins agent..."

nohup java -jar /tmp/agent.jar \
-url http://localhost:8080 \
-secret $SECRET \
-name $NAME \
-webSocket \
-workDir /home/ubuntu/$NAME \
> /home/ubuntu/$NAME/agent.log 2>&1 &

echo "Agent connected successfully : $NAME"

echo "Executors running on $NAME : $EXECUTORS"

echo "------------------------------------------------"

done

echo "================================================"
echo "ALL DONE SUCCESSFULLY"
echo "================================================"