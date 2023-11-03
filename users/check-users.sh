#!/bin/bash

getent passwd $user > /dev/null

if [ $? -ne 0 ]; then
    echo "Account not exist for $user"    
    echo "1" > $HOME/.ikctl/user_not_exist
else  
    echo "Account already exists for $user"
    rm -rf $HOME/.ikctl/user_not_exist
fi