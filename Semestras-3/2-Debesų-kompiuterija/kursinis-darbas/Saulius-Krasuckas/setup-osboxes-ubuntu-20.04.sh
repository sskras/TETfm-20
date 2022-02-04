#!/usr/bin/env bash

IP=$1

sshpass -p osboxes.org ssh-copy-id -o StrictHostKeyChecking=no osboxes@${IP}
ssh osboxes@${IP} "sudo -p '' -S bash -c 'echo osboxes ALL=\(ALL:ALL\) NOPASSWD: ALL | tee /etc/sudoers.d/osboxes'" < <(echo osboxes.org)

ssh osboxes@${IP}
