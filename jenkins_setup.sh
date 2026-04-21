#!/bin/bash

set -e  # Stop script immediately if any command fails (safe for automation/CI-CD)

sudo apt update  # Update package list from all configured repositories

# Install required tools for adding external repositories and secure package downloads
sudo apt install -y wget apt-transport-https gpg software-properties-common

# Download Adoptium (Java) GPG key and convert it to trusted format for apt
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | sudo tee /usr/share/keyrings/adoptium.gpg > /dev/null

# Add Adoptium repository to install Temurin JDK (Java 21)
echo "deb [signed-by=/usr/share/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/adoptium.list

# Update package list after adding new repository
sudo apt update

# Install Java 21 (required for Jenkins and modern applications)
sudo apt install -y temurin-21-jdk

# Add Jenkins official repository to install Jenkins package
echo "deb [trusted=yes] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list

# Update package list after adding Jenkins repo
sudo apt update

# Install Jenkins automation server
sudo apt install -y jenkins

# Enable Jenkins service to start automatically on system boot
sudo systemctl enable jenkins

# Start Jenkins service immediately
sudo systemctl start jenkins

# Check Jenkins service status (verify installation success)
sudo systemctl status jenkins --no-pager