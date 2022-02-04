#!/usr/bin/env bash

IP=$1
TEMPLATE_HOSTNAME="dkkd-saukrs-TODO"

sshpass -p osboxes.org ssh-copy-id -o StrictHostKeyChecking=no osboxes@${IP}
ssh osboxes@${IP} "sudo -p '' -S bash -c 'echo osboxes ALL=\(ALL:ALL\) NOPASSWD: ALL | tee /etc/sudoers.d/osboxes'" < <(echo osboxes.org)

ssh osboxes@${IP} "echo -e '127.0.2.1\t${TEMPLATE_HOSTNAME}' | sudo tee /etc/hosts"
ssh osboxes@${IP} "sudo hostnamectl set-hostname ${TEMPLATE_HOSTNAME}"
ssh osboxes@${IP} "hostname"
ssh osboxes@${IP} "hostnamectl"
echo -n "Upgreidinam? "; read
ssh osboxes@${IP} "sudo apt upgrade"
echo -n "Rebūtinam? "; read
ssh osboxes@${IP} "reboot"
ssh osboxes@${IP}
