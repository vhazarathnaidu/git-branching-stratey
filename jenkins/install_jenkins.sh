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
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "Access Jenkins at http://localhost:8080"

ADMIN_USER="admin"

# Read initial admin password
ADMIN_PASS=$(cat /var/lib/jenkins/secrets/initialAdminPassword)

java -jar "jenkins-cli.jar" -s "http://localhost:8080" -auth $ADMIN_USER:$ADMIN_PASS groovy = < create_jenkins_user.groovy
echo "Admin user created jenkins/jenkins"

# /tmp 
#sudo systemctl stop jenkins
#sudo rm -rf /tmp/*
#echo 'tmpfs /tmp tmpfs defaults,noatime,mode=1777,size=2g 0 0' | sudo tee -a /etc/fstab
#sudo mount -o remount /tmp
#sudo systemctl start jenkins