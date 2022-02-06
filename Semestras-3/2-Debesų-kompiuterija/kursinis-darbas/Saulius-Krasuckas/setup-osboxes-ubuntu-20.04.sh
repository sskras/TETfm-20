#!/usr/bin/env bash

IP=$1

# Panaudosiu Cygwin ping portą vietoj nebesveikai nesiintegruojančio NT porto:
. ~/bin/ping-NT-fixes.sh

echo
echo - SSH rakto kopijavimas:
echo
sshpass -p osboxes.org ssh-copy-id -o StrictHostKeyChecking=no osboxes@${IP}

echo
echo - Pagrindinis OS setupas ...
echo
cat osboxes-ubuntu-20.04-changes.sh | ssh osboxes@${IP}

echo
echo - Laukiam IP išjungimo:
echo
ping -c 4 -W 1 ${IP} | sed "1d; / ms$/! q"

echo
echo - Laukiam IP įjungimo:
echo
ping ${IP} | sed "/ ms$/ q"

echo
echo - Docker diegimas ...
echo
cat setup-ubuntu-docker.sh | ssh osboxes@${IP}

echo
echo - Paskutinis patikrinimas, uptime:
echo
ssh osboxes@${IP} "uptime"
