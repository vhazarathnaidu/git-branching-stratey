#!/bin/bash

# Update system and install Java 21 (required for Jenkins)
sudo apt update
sudo apt install -y fontconfig openjdk-21-jre

# Add Jenkins repository key (LTS stable release)
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# Add Jenkins repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list and install Jenkins
sudo apt update
sudo apt install -y jenkins

# Start and enable Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Display initial admin password
echo "Jenkins installed! Initial admin password:"

echo "Access Jenkins at http://localhost:8080"

ADMIN_USER="admin"

# Read initial admin password
ADMIN_PASS=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

echo "Admin password ${ADMIN_PASS}"

public_ip=$(sudo curl -s ifconfig.me)
echo "public_ip ${public_ip}"

url="http://${public_ip}:8080/jnlpJars/jenkins-cli.jar"
echo "url ${url}"

wget -q http://localhost:8080/jnlpJars/jenkins-cli.jar
echo "jenkins cli downloaded"
ls -ltr

sudo mkdir -p /var/lib/jenkins/init.groovy.d

sudo tee /var/lib/jenkins/init.groovy.d/set-url.groovy > /dev/null <<EOF
import jenkins.model.*
import jenkins.model.JenkinsLocationConfiguration

def ip = "http://${public_ip}:8080/"

def jlc = JenkinsLocationConfiguration.get()
jlc.setUrl(ip)
jlc.save()

println("Jenkins URL auto-set to: " + ip)
EOF

sudo systemctl restart jenkins

echo "jenkins Configuration done..."

sudo tee /var/lib/jenkins/init.groovy.d/create-admin.groovy > /dev/null <<EOF
import jenkins.model.*
import hudson.security.*
import jenkins.security.s2m.AdminWhitelistRule

def instance = Jenkins.getInstance()

def username = "jenkins"
def password = "jenkins"

// Get security realm
def hudsonRealm = instance.getSecurityRealm()

// Check if user already exists
def user = hudson.model.User.getById(username, false)

// Create user
hudsonRealm.createAccount(username, password)
println "User created: ${username}"

// Setup authorization strategy (Full control once logged in OR matrix-based)
def strategy = new GlobalMatrixAuthorizationStrategy()

// Grant all permissions to admin user
strategy.add(Jenkins.ADMINISTER, username)

instance.setAuthorizationStrategy(strategy)

// Save Jenkins config
instance.save()

EOF


sudo systemctl restart jenkins




# /tmp 
#sudo systemctl stop jenkins
#sudo rm -rf /tmp/*
#echo 'tmpfs /tmp tmpfs defaults,noatime,mode=1777,size=2g 0 0' | sudo tee -a /etc/fstab
#sudo mount -o remount /tmp
#sudo systemctl start jenkins