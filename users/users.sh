#!/bin/bash

function check_user(){
    getent passwd $user > /dev/null
    if [ $? -ne 0 ]; then
        echo "not_exist"    
    else  
        echo "exists"
    fi
}

function add_user(){
    echo -e "Create user $user\n"
    adduser --home /home/$user --shell /bin/bash --disabled-password --gecos GECOS $user

    echo -e "Change password\n"
    echo -en "${pass}\n${pass}\n${pass}\n" | passwd $user
    echo -e "User $user created\n"
}

function add_ssh_key(){
    echo -e "Enable access from ssh keys\n"
    if [ -e .ikctl/id_rsa_${user}.pub ]; then
        mkdir -p /home/$user/.ssh/
        touch /home/$user/.ssh/authorized_keys
        cat .ikctl/id_rsa_${user}.pub >> /home/$user/.ssh/authorized_keys
    fi

    chmod 700 /home/$user/.ssh
    chmod 600 /home/$user/.ssh/authorized_keys
    chown $(getent passwd | grep ${user} | cut -d ":" -f 3):$(getent passwd | grep ${user} | cut -d ":" -f 4) /home/$user -R
    echo -e "key to $user add\n"
}

function add_sudoers(){
    echo -e "Add nopasswd in sodoers group\n"
    echo -e "${user} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$user
    chmod 440 /etc/sudoers.d/$user
    usermod -aG sudo $user
    echo -e "User $user add to sudoers\n"
}