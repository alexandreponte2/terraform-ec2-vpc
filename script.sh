#!/bin/bash
sudo apt-get update
sudo apt install -y openjdk-8-jre-headless
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install -y jenkins
sudo systemctl start jenkins
sudo apt install -y docker
apt install -y docker.io
sudo groupadd docker
sudo usermod -aG docker jenkins