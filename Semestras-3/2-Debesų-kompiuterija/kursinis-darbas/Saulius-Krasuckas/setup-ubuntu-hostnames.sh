shopt -s lastpipe

APP_IF_NUM=2
HOSTNAME=$1

get_IF_by_numb () {
    ip a | awk 'BEGIN {FS="[ :]+"} /^[0-9]/ {NUM++; if (NUM=='$1') print $2}'
}

get_IP_by_name () {
    ip a show dev $1 | awk 'BEGIN {FS="[ /]+"} /inet / {print $3}'
}

get_IF_by_numb 2 | read APP_IF
get_IP_by_name ${APP_IF} | read APP_IP

echo -e "${APP_IP}\t${HOSTNAME}" | sudo tee -a /etc/hosts
