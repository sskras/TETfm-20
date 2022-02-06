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

while read -u 8 REMOTE_CMD; do
    [ "$REMOTE_CMD" = "" ] && continue
    [ "${REMOTE_CMD::1}" = "#" ] && continue
    echo
   #echo "Remote CMD is: $REMOTE_CMD"
    ssh osboxes@${IP} "$REMOTE_CMD"
    [ $? -eq 0 ] && continue
    echo
    echo "Command failed, skipping the remainder."
    exit
done 8< osboxes-ubuntu-20.04-changes.sh

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
