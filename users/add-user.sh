#!/bin/bash

echo -e "Create user $user with uid $uid\n"
adduser --home /home/$user --shell /bin/bash --disabled-password --gecos GECOS $user

echo -e "Change password\n"
echo -en "${pass}\n${pass}\n${pass}\n" | passwd $user

echo -e "Enable access from ssh keys\n"
if [ -e $HOME/.ikctl/id_rsa_${user}.pub ]; then
    mkdir -p /home/$user/.ssh/
    touch /home/$user/.ssh/authorized_keys
    cat $HOME/.ikctl/id_rsa_${user}.pub >> /home/$user/.ssh/authorized_keys
fi

chmod 700 /home/$user/.ssh
chmod 600 /home/$user/.ssh/authorized_keys
chown $(getent passwd | grep ${user} | cut -d ":" -f 3).$(getent passwd | grep ${user} | cut -d ":" -f 4) /home/$user -R

echo -e "Add nopasswd in sodoers group\n"
echo -e "${user} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$user
chmod 440 /etc/sudoers.d/$user
usermod -aG sudo $user