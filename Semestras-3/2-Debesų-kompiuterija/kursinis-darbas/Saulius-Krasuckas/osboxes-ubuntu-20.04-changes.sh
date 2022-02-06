TEMPLATE_HOSTNAME="sksw-TODO"

echo
echo - sudo be promptų:
echo
sudo -p '' -S bash -c "echo osboxes ALL=\(ALL:ALL\) NOPASSWD: ALL | tee /etc/sudoers.d/osboxes" <<< osboxes.org

echo
echo - sudo be lago:
echo
echo -e "127.0.2.1\t${TEMPLATE_HOSTNAME}" | sudo tee -a /etc/hosts
echo
sudo hostnamectl set-hostname ${TEMPLATE_HOSTNAME}
hostnamectl

echo
echo - Laiko juosta:
echo
sudo timedatectl set-timezone Europe/Vilnius
timedatectl

echo
echo - Laiko formatas be AM/PM:
echo
sudo localectl set-locale LC_TIME=C.UTF-8
localectl
echo
date

echo
echo - APT Mirror perjungimas:
echo
# Add nearer APT mirror?

# sudo sed -i.BACKUP-1 's|us.archive.ubuntu.com|ubuntu.mirror.vu.lt|' /etc/apt/sources.list
# sudo sed -i.BACKUP-2 's|security.ubuntu.com|ubuntu.mirror.vu.lt|' /etc/apt/sources.list

echo
echo - Upgreidinam:
sudo apt update
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
sudo DEBIAN_FRONTEND=noninteractive apt install -y vim colordiff pv curl iotop htop sysstat

echo
echo - Rebūtinam:
echo
nohup sudo -b bash -c "sleep 2; reboot"
