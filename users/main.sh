#!/bin/bash

echo -e "Load env\n"

export users=$*
export pass="changeme01"

for usr in $users
do
    export user=$usr

    chmod u+x $HOME/.ikctl/check-users.sh
    bash -c $HOME/.ikctl/check-users.sh

    echo -e "$user_exist\n"

    if [ -e $HOME/.ikctl/user_not_exist ]; then
        chmod u+x $HOME/.ikctl/add-user.sh
        bash -c $HOME/.ikctl/add-user.sh
    fi

done
