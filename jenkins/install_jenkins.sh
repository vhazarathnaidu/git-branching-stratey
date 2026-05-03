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

java -jar jenkins-cli.jar -s http://localhost:8080 \
-auth $ADMIN_USER:$ADMIN_PASS groovy = <<EOF
import jenkins.model.*
import jenkins.model.JenkinsLocationConfiguration

def jlc = JenkinsLocationConfiguration.get()
jlc.setUrl("http://${PUBLIC_IP}:8080/")
jlc.save()

println("Jenkins URL set to: http://${PUBLIC_IP}:8080/")
EOF

echo "jenkins Configuration done..."

java -jar "jenkins-cli.jar" -s "http://${public_ip}:8080" -auth $ADMIN_USER:$ADMIN_PASS groovy < jenkins/create_jenkins_user.groovy
echo "Admin user created jenkins/jenkins"

sudo systemctl stop jenkins
sudo systemctl start jenkins




# /tmp 
#sudo systemctl stop jenkins
#sudo rm -rf /tmp/*
#echo 'tmpfs /tmp tmpfs defaults,noatime,mode=1777,size=2g 0 0' | sudo tee -a /etc/fstab
#sudo mount -o remount /tmp
#sudo systemctl start jenkins