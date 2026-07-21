#!/bin/bash

# Update package list
sudo apt update -y

# Install Java (required for Jenkins)
sudo apt install openjdk-21-jre -y

# Create keyrings directory if not exists
sudo mkdir -p /etc/apt/keyrings

# Download Jenkins GPG key
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# Add Jenkins repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list after adding repo
sudo apt update -y

# Install Jenkins
sudo apt install jenkins -y

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins on boot
sudo systemctl enable jenkins

# Check status
sudo systemctl status jenkins