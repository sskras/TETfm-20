#!/usr/bin/env bash

IP=$1

sshpass -p osboxes.org ssh-copy-id -o StrictHostKeyChecking=no osboxes@${IP}
ssh osboxes@${IP}
