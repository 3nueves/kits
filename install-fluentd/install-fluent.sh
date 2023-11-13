#!/bin/bash
#
# Delfos Forwarder
# Compatible with Linux x64 SYSTEMD based systems

# Installation must be run as root
if ! [ $(id -u) = 0 ]
then
   echo "\nInstallation must be run as root\n"
   exit 1
fi

# upload version

if ! [ -f /etc/os-release ]
then
  echo "File os-release not found"
  exit 1
fi  

source /etc/os-release

echo -e "\n-=[ Delfos Forwarder installation\n"

apt-get update
apt install -y curl sudo ntp apt-transport-https gnupg gnupg1 gnupg2
test $ID = "debian" && curl -fsSL https://toolbelt.treasuredata.com/sh/install-debian-bullseye-td-agent4.sh | sh
test $ID = "ubuntu" && curl -fsSL https://toolbelt.treasuredata.com/sh/install-ubuntu-jammy-fluent-package5-lts.sh | sh

echo -e "Install fluent-plugin-beats...\n"
/opt/fluent/bin/fluent-gem install fluent-plugin-beats --no-document

echo -e "Create buffer directory\n"
mkdir -p /opt/buffer
chmod 777 /opt/buffer

cp .ikctl/forwarder.conf  /etc/fluent/td-agent.conf

systemctl start td-agent

echo -e "\n[+] Installation completed\n"