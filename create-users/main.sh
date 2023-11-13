#!/bin/bash

source .ikctl/users.sh

export users=$*
export pass="changeme01"

for usr in ${users[@]}
do
    export user=$usr
    value=$(check_user)

    if [ ${value} = "not_exist" ]; then
        add_user
        add_ssh_key
        add_sudoers
    else
        echo -e "$user already exist\n"
    fi

done
