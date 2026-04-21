#!/bin/bash

# system lo unna package list ni latest ga update chestundi
sudo apt update

# Java install chestundi (Jenkins run avvadam ki Java compulsory)
sudo spt install open jdk-21-jre -y

# Jenkins official security key ni download chesi system lo save chestundi
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc\
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# Jenkins repository ni add chestundi (ekkada nundi Jenkins download cheyyalo system ki chepthundi)
echo "deb[signed-by=/etc/apt/keyrings/jenkins-keyring.asc]"\
https://pkg.jenkins.io/debian-stable binary | sudo tee \
/etc/apt/sources.list.d/jenkins.list>/dev/null

#kotha repository add ayyaka malli update chestundi
sudo apt update 

# Jenkins ni install chestundi
sudo apt install jenkins -y

#System restart ayina prathi sari Jenkins automatic ga start avvali ani set chestundi.
sudo systemctl start jenkins

#Jenkins ni manual ga start chestundi
sudo systemctl enable jenkins 

#Jenkins run avtunda, stop ayinda, error unda ani check chestundi.
sudo systemctl status jnekins




