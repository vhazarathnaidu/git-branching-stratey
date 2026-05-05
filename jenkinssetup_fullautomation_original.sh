#!/bin/bash

set -e

# -----------------------------
# CONFIG
# -----------------------------
JENKINS_USER="admin"
JENKINS_PASS="admin123"
FULL_NAME="Venkatesh"
EMAIL="venky@example.com"

# -----------------------------
# Update system and install Java 21 (required for Jenkins)
# -----------------------------
sudo apt update
sudo apt install -y fontconfig openjdk-21-jre

# -----------------------------
#  Add Jenkins repository key (LTS stable release)
# -----------------------------
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
# --------------------------------------
# Add Jenkins repository
# --------------------------------------
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# ---------------------------------------
# Update package list and install Jenkins
# ---------------------------------------
sudo apt update
sudo apt install -y jenkins

# -----------------------------
# STEP 3: START JENKINS
# -----------------------------
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Jenkins installed! Sucessfully!!!"
sleep 40

# -----------------------------
# STEP 4: GET PUBLIC IP
# -----------------------------
PUBLIC_IP=$(curl -s ifconfig.me)
JENKINS_URL="http://${PUBLIC_IP}:8080"

echo "Jenkins URL: $JENKINS_URL"

# -----------------------------
# STEP 5: GET INITIAL PASSWORD
# -----------------------------
INIT_PASS=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

echo "Initial Password: $INIT_PASS"

# -----------------------------
# STEP 6: DOWNLOAD CLI
# -----------------------------
wget $JENKINS_URL/jnlpJars/jenkins-cli.jar

until curl -s $JENKINS_URL/login > /dev/null; do
  echo "Waiting for Jenkins..."
  sleep 10
done

# -----------------------------
# Install FULL Plugins
# -----------------------------
echo "Fetching plugin list..."

PLUGIN_LIST=$(curl -s https://raw.githubusercontent.com/jenkinsci/jenkins/master/core/src/main/resources/jenkins/install/platform-plugins.json | jq -r '.[].plugins[].name')

echo "Starting plugin installation..."

for plugin in $PLUGIN_LIST; do
  echo "Installing plugin: $plugin"
  java -jar jenkins-cli.jar -s $JENKINS_URL -auth admin:$INIT_PASS install-plugin $plugin
done

echo "All plugins installation completed!"

#PLUGIN_LIST=$(curl -s https://raw.githubusercontent.com/jenkinsci/jenkins/master/core/src/main/resources/jenkins/install/platform-plugins.json | jq -r '.[].plugins[].name')

#java -jar jenkins-cli.jar -s $JENKINS_URL -auth admin:$INIT_PASS install-plugin $PLUGIN_LIST


# Restart after plugin install
java -jar jenkins-cli.jar -s $JENKINS_URL -auth admin:$INIT_PASS safe-restart

sleep 60


# -----------------------------
# STEP 8: CREATE ADMIN USER
# -----------------------------
cat <<EOF > create-user.groovy
import jenkins.model.*
import hudson.security.*

def instance = Jenkins.get()

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("${JENKINS_USER}", "${JENKINS_PASS}")
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
instance.setAuthorizationStrategy(strategy)

instance.save()
EOF

cat create-user.groovy | java -jar jenkins-cli.jar -s $JENKINS_URL -auth admin:$INIT_PASS groovy = 

# -----------------------------
# STEP 9: DISABLE SETUP WIZARD
# -----------------------------
echo "2.0" | sudo tee /var/lib/jenkins/jenkins.install.UpgradeWizard.state

# -----------------------------
# STEP 10: RESTART JENKINS
# -----------------------------
sudo systemctl restart jenkins
sleep 20

# -----------------------------
# DONE
# -----------------------------
echo "----------------------------------"
echo "JENKINS READY ✅"
echo "URL: $JENKINS_URL"
echo "USERNAME: $JENKINS_USER"
echo "PASSWORD: $JENKINS_PASS"
echo "----------------------------------"