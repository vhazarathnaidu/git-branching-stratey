#!/bin/bash

set -e

# -----------------------------
# CONFIG
# -----------------------------
JENKINS_USER="admin"
JENKINS_PASS="admin123"
TOKEN_NAME="automation-token"
LATEST_JENKINS_URL="https://pkg.jenkins.io/debian/binary/jenkins_2.532_all.deb"

echo "Starting Jenkins 2.532 Installation with 30 Main Plugins..."

# -----------------------------
# 1. TOOLS INSTALLATION
# -----------------------------
sudo apt-get update || true
sudo apt-get install -y fontconfig openjdk-21-jre jq curl wget

# -----------------------------
# 2. DIRECT JENKINS INSTALL (Bypassing Repo Errors)
# -----------------------------
echo "Downloading Jenkins 2.532..."
wget -q $LATEST_JENKINS_URL -O /tmp/jenkins.deb
sudo dpkg -i /tmp/jenkins.deb || sudo apt-get install -f -y
sudo systemctl stop jenkins

# -----------------------------
# 3. SELECT TOP 30 PLUGINS
# -----------------------------
echo "Preparing 30 Essential Plugins..."
sudo rm -rf /var/lib/jenkins/plugins/*
sudo mkdir -p /var/lib/jenkins/plugins

cat <<EOF > /tmp/plugins.txt
workflow-aggregator
workflow-multibranch
pipeline-stage-view
pipeline-model-definition
pipeline-graph-analysis
git
git-client
github
github-branch-source
docker-workflow
docker-plugin
kubernetes
kubernetes-cli
aws-credentials
aws-java-sdk
amazon-ecr
maven-plugin
nodejs
gradle
config-file-provider
credentials-binding
ssh-slaves
matrix-auth
role-strategy
blueocean
ansicolor
email-ext
junit
slack
conditional-buildstep
EOF

# Plugin manager download
wget -q -O /tmp/plugin-manager.jar https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.13.0/jenkins-plugin-manager-2.13.0.jar

echo "Downloading plugins (3-5 minutes time paduthundi)..."
sudo java -jar /tmp/plugin-manager.jar \
  --plugin-file /tmp/plugins.txt \
  --plugin-download-directory /var/lib/jenkins/plugins \
  --war /usr/share/java/jenkins.war

sudo chown -R jenkins:jenkins /var/lib/jenkins/plugins

# -----------------------------
# 4. AUTO-CONFIG & ADMIN SETUP
# -----------------------------
echo "2.0" | sudo tee /var/lib/jenkins/jenkins.install.UpgradeWizard.state
sudo mkdir -p /etc/systemd/system/jenkins.service.d
echo -e "[Service]\nEnvironment=\"JAVA_OPTS=-Djenkins.install.runSetupWizard=false\"" | sudo tee /etc/systemd/system/jenkins.service.d/override.conf

sudo mkdir -p /var/lib/jenkins/init.groovy.d
cat <<EOF | sudo tee /var/lib/jenkins/init.groovy.d/basic-security.groovy
import jenkins.model.*
import hudson.security.*
import jenkins.security.*
def instance = Jenkins.getInstance()
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("$JENKINS_USER", "$JENKINS_PASS")
instance.setSecurityRealm(hudsonRealm)
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)
instance.save()
EOF

sudo chown -R jenkins:jenkins /var/lib/jenkins/
sudo systemctl daemon-reload
sudo systemctl start jenkins

# -----------------------------
# 5. TOKEN GENERATION
# -----------------------------
echo "Waiting for Jenkins to be ready..."
until curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/login | grep "200" > /dev/null; do 
    echo -n "."
    sleep 5
done
echo ""

cat <<EOF > /tmp/gen-token.groovy
import jenkins.model.*
import hudson.model.*
import jenkins.security.*
def user = User.get('$JENKINS_USER')
def prop = user.getProperty(ApiTokenProperty.class)
def token = prop.tokenStore.generateNewToken('$TOKEN_NAME')
user.save()
println token.plainValue
EOF

wget -q http://localhost:8080/jnlpJars/jenkins-cli.jar
API_TOKEN=$(java -jar jenkins-cli.jar -s http://localhost:8080/ -auth $JENKINS_USER:$JENKINS_PASS groovy = < /tmp/gen-token.groovy)

# -----------------------------
# 6. FINAL OUTPUT
# -----------------------------
PUBLIC_IP=$(curl -s ifconfig.me || echo "localhost")
echo "------------------------------------------------"
echo "✅ JENKINS SETUP SUCCESSFUL!"
echo "URL: http://${PUBLIC_IP}:8080"
echo "USER: $JENKINS_USER"
echo "PASS: $JENKINS_PASS"
echo "API TOKEN: $API_TOKEN"
echo "------------------------------------------------"

 