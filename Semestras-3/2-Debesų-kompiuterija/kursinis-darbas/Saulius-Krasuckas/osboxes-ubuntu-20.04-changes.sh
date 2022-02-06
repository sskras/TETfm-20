TEMPLATE_HOSTNAME="sksw-TODO"

    sudo -p '' -S bash -c 'echo osboxes ALL=\\\(ALL:ALL\\\) NOPASSWD: ALL | tee /etc/sudoers.d/osboxes' <<< osboxes.org

    echo -e '127.0.2.1\\\t${TEMPLATE_HOSTNAME}' | sudo tee -a /etc/hosts
   #sudo hostnamectl set-hostname ${TEMPLATE_HOSTNAME}
    hostnamectl

    sudo timedatectl set-timezone Europe/Vilnius
    timedatectl

    sudo localectl set-locale LC_TIME=C.UTF-8
    localectl
    date

    # Add nearer APT mirror?

    # sudo sed -i.BACKUP-1 's|us.archive.ubuntu.com|ubuntu.mirror.vu.lt|' /etc/apt/sources.list
    # sudo sed -i.BACKUP-2 's|security.ubuntu.com|ubuntu.mirror.vu.lt|' /etc/apt/sources.list

    echo -n "Upgreidinam:"
    sudo apt update
    sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
    sudo DEBIAN_FRONTEND=noninteractive apt install -y vim colordiff pv curl iotop htop sysstat

    echo -n "Rebūtinam:"
    nohup sudo -b bash -c 'sleep 2; reboot'
