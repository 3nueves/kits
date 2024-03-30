#!/bin/bash

# This kit install docker enginee on Debian
# maintained by 3ozone

echo -e "Add Docker's official GPG key-------\n"
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo -e "Add the repository to Apt sources---\n"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo -e "\nInstall Docker-------------------\n" 
VERSION_STRING=5:25.0.0-1~debian.12~bookworm

sudo apt-get install -y docker-ce=$VERSION_STRING \
                        docker-ce-cli=$VERSION_STRING \
                        containerd.io \
                        docker-buildx-plugin \
                        docker-compose-plugin