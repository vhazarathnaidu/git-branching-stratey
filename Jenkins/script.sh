#!/bin/bash

# Update system
sudo apt update -y

# Install Java (Jenkins requires Java)
sudo apt install openjdk-21-jre -y

# Create keyrings directory
sudo mkdir -p /etc/apt/keyrings

# Download Jenkins key
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /etc/apt/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update repo
sudo apt update -y

# Install Jenkins
sudo apt install jenkins -y

# Start Jenkins
sudo systemctl start jenkins

# Enable Jenkins at boot
sudo systemctl enable jenkins

# Check status
sudo systemctl status jenkins