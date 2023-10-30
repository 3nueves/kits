#!/bin/bash

#This script will ask the user for their name, and if no such user exists will create a user

username=$1

getent passwd $username > /dev/null

    if [ $? -ne 0 ]; then

        for i in $username;

        do 
            adduser --home /home/$USER --shell /bin/bash --disabled-password --gecos GECOS $USER;

            echo -e "Change password\n"

            echo -en "changeme01\nchangeme01\nchangeme01\n" | passwd $USER

            echo -e "Enable access from ssh keys\n"

            mkdir -p /home/$USER/.ssh/

            touch /home/$USER/.ssh/authorized_keys

            cat $HOME/.ikctl/id_rsa_kubernetes-unelink.pub >> /home/$USER/.ssh/authorized_keys

            chmod 700 /home/$USER/.ssh

            chmod 600 /home/$USER/.ssh/authorized_keys

            chown 1000.1000 /home/$USER -R

            echo -e "Add nopasswd in sodoers group\n"

            echo -e "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USER

            chmod 440 /etc/sudoers.d/$USER
            
            usermod -aG sudo $USER

            echo "Success. An account has been created for $username."      

        done

   else  echo "Denied. An account already exists for $username"

   fi