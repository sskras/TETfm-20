#!/bin/bash

# 2022-02-06 saukrs: From the run of docker-install script, commit: 93d2499759296ac1f9c510605fef85052a2c32be

sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y apt-transport-https ca-certificates curl
curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | sudo gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y docker-ce-cli docker-scan-plugin docker-ce
sudo DEBIAN_FRONTEND=noninteractive apt install -y docker-ce-rootless-extras
sudo docker version
