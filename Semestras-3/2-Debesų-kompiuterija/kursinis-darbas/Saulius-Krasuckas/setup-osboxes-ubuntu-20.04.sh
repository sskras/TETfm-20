#!/usr/bin/env bash

IP=$1
TEMPLATE_HOSTNAME="cckd-saukrs-TODO"

sshpass -p osboxes.org ssh-copy-id -o StrictHostKeyChecking=no osboxes@${IP}
ssh osboxes@${IP} "sudo -p '' -S bash -c 'echo osboxes ALL=\(ALL:ALL\) NOPASSWD: ALL | tee /etc/sudoers.d/osboxes'" <<< osboxes.org

ssh osboxes@${IP} "echo -e '127.0.2.1\t${TEMPLATE_HOSTNAME}' | sudo tee /etc/hosts"
ssh osboxes@${IP} "sudo hostnamectl set-hostname ${TEMPLATE_HOSTNAME}"
ssh osboxes@${IP} "hostnamectl"
ssh osboxes@${IP} "sudo timedatectl set-timezone Europe/Vilnius"
ssh osboxes@${IP} "timedatectl"
ssh osboxes@${IP} "sudo localectl set-locale LC_TIME=C.UTF-8"
ssh osboxes@${IP} "localectl"
echo
echo -n "Upgreidinam? "; read
ssh osboxes@${IP} "sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y"
echo
echo -n "Rebūtinam? "; read
ssh osboxes@${IP} "sudo reboot"
# TODO ping-wait for ${IP}
echo
echo -n "Jau VM gyva? "; read

ssh osboxes@${IP} "echo install Docker here or in another script ?"
ssh osboxes@${IP}
