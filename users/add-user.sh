#!/bin/bash
# v1.0 by David Moya

USER=$1
uid=$2

echo -e "Create user $USER with uid $uid\n"
adduser --home /home/$USER --shell /bin/bash --uid $uid --disabled-password --gecos GECOS $USER

echo -e "Change password\n"
echo -en "changeme01\nchangeme01\nchangeme01\n" | passwd $USER

echo -e "Enable access from ssh keys\n"
mkdir -p /home/$USER/.ssh/
touch /home/$USER/.ssh/authorized_keys
cat $HOME/.ikctl/id_rsa_kubernetes-unelink.pub >> /home/$USER/.ssh/authorized_keys
chmod 700 /home/$USER/.ssh
chmod 600 /home/$USER/.ssh/authorized_keys
chown $uid.$(getent passwd | grep ${USER} | cut -d ":" -f 4) /home/$USER -R

echo -e "Add nopasswd in sodoers group\n"
echo -e "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USER
chmod 440 /etc/sudoers.d/$USER
usermod -aG sudo $USER

echo -e "Change keywoard to ES\n"
sed -i "s/pc105/pc104/g" /etc/default/keyboard
sed -i "s/gb/es/g" /etc/default/keyboard