#!/bin/bash

set -e

# -----------------------------
# CONFIG
# -----------------------------
JENKINS_USER="admin"
JENKINS_PASS="admin123"

# -----------------------------
# Install Java + tools
# -----------------------------
sudo apt update
sudo apt install -y fontconfig openjdk-21-jre jq curl wget

# -----------------------------
# Add Jenkins repo
# -----------------------------
sudo mkdir -p /etc/apt/keyrings

if [ ! -f /etc/apt/keyrings/jenkins-keyring.asc ]; then
  sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
fi

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list

sudo apt update
sudo apt install -y jenkins

# -----------------------------
# STOP JENKINS (IMPORTANT)
# -----------------------------
sudo systemctl stop jenkins

# -----------------------------
# PRELOAD SUGGESTED PLUGINS 🔥
# -----------------------------
echo "Preloading suggested plugins..."

sudo mkdir -p /usr/share/jenkins/ref/plugins
cd /tmp

curl -s https://raw.githubusercontent.com/jenkinsci/jenkins/master/core/src/main/resources/jenkins/install/platform-plugins.json \
| jq -r '.categories[].plugins[].name' | sort -u \
| sed 's/$/:latest/' > plugins.txt

wget -O plugin-manager.jar \
https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.13.0/jenkins-plugin-manager-2.13.0.jar

sudo java -jar plugin-manager.jar \
  --plugin-file plugins.txt \
  --plugin-download-directory /usr/share/jenkins/ref/plugins

# Copy plugins to Jenkins home
sudo mkdir -p /var/lib/jenkins/plugins
sudo cp -r /usr/share/jenkins/ref/plugins/* /var/lib/jenkins/plugins/

# Fix permissions
sudo chown -R jenkins:jenkins /var/lib/jenkins

# -----------------------------
# DISABLE SETUP WIZARD
# -----------------------------
echo "2.0" | sudo tee /var/lib/jenkins/jenkins.install.UpgradeWizard.state

sudo mkdir -p /etc/systemd/system/jenkins.service.d
echo -e "[Service]\nEnvironment=\"JAVA_OPTS=-Djenkins.install.runSetupWizard=false\"" | sudo tee /etc/systemd/system/jenkins.service.d/override.conf

sudo systemctl daemon-reexec
sudo systemctl daemon-reload

# -----------------------------
# CREATE ADMIN USER
# -----------------------------
sudo mkdir -p /var/lib/jenkins/init.groovy.d

cat <<EOF | sudo tee /var/lib/jenkins/init.groovy.d/basic-setup.groovy
import jenkins.model.*
import hudson.security.*
import hudson.model.*
import jenkins.security.apitoken.*

def instance = Jenkins.get()

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("${JENKINS_USER}", "${JENKINS_PASS}")
instance.setSecurityRealm(hudsonRealm)

instance.setAuthorizationStrategy(new FullControlOnceLoggedInAuthorizationStrategy())

def user = User.get("${JENKINS_USER}")
def tokenStore = user.getProperty(ApiTokenProperty.class).tokenStore
def token = tokenStore.generateNewToken("auto-token")

def file = new File("/var/lib/jenkins/api_token.txt")
file.text = token.plainValue

instance.save()
EOF

# -----------------------------
# START JENKINS
# -----------------------------
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Waiting for Jenkins..."
sleep 90

# -----------------------------
# OUTPUT
# -----------------------------
PUBLIC_IP=$(curl -s ifconfig.me)
API_TOKEN=$(sudo cat /var/lib/jenkins/api_token.txt)

echo "----------------------------------"
echo "JENKINS READY ✅"
echo "URL: http://${PUBLIC_IP}:8080"
echo "USERNAME: $JENKINS_USER"
echo "PASSWORD: $JENKINS_PASS"
echo "API TOKEN: $API_TOKEN"
echo "----------------------------------"