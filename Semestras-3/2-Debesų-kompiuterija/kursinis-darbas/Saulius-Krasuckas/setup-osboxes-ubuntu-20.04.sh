#!/usr/bin/env bash

IP=$1

# Panaudosiu Cygwin ping portą vietoj nebesveikai nesiintegruojančio NT porto:
. ~/bin/ping-NT-fixes.sh

sshpass -p osboxes.org ssh-copy-id -o StrictHostKeyChecking=no osboxes@${IP}

echo "Komandų receptas:"
echo
echo "......................................................................................................................"
cat osboxes-ubuntu-20.04-changes.sh
echo "......................................................................................................................"
echo

cat osboxes-ubuntu-20.04-changes.sh | ssh osboxes@${IP}

echo
echo - Laukiam IP išjungimo:
ping -c 4 -W 1 ${IP} | sed "1d; / ms$/! q"

echo
echo - Laukiam IP įjungimo:
ping ${IP} | sed "/ ms$/ q"

echo
echo - Docker diegimas ...
cat setup-ubuntu-docker.sh | ssh osboxes@${IP}

echo
echo - Paskutinis patikrinimas, uptime:
ssh osboxes@${IP} "uptime"
