shopt -s lastpipe
ip a | awk 'BEGIN {FS="[ :]+"} /^[0-9]/ {NUM++; if (NUM==2) print $2}' | read APP_IF
ip a show dev ${APP_IF} | awk 'BEGIN {FS="[ /]+"} /inet / {print $3}' | read APP_IP
