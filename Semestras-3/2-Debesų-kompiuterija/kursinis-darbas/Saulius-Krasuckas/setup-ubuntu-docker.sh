#!/bin/sh

# 2022-02-06 saukrs: From the run of docker-install script, commit: 93d2499759296ac1f9c510605fef85052a2c32be

echo - Paketų indekso naujinimas:
sudo apt update

echo
echo - curl diegimas + https palaikymas:
sudo DEBIAN_FRONTEND=noninteractive apt install -y apt-transport-https ca-certificates curl

echo
echo - Docker Ubuntu GPG raktai:
echo
curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | sudo gpg --dearmor --yes -o /usr/share/keyrings/docker-archive-keyring.gpg

echo
echo - Docker APT repo:
echo
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list

echo
echo - Paketų indekso naujinimas:
sudo apt update

echo
echo - Docker CE diegimas:
sudo DEBIAN_FRONTEND=noninteractive apt install -y docker-ce-cli docker-scan-plugin docker-ce

echo
echo - Docker Rootless įrankiai:
sudo DEBIAN_FRONTEND=noninteractive apt install -y docker-ce-rootless-extras

echo
echo - Versija:
echo
sudo docker version
