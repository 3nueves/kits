#!/bin/bash

#This script will ask the user for their name, and if no such user exists will create a user

username=$1

getent passwd $username > /dev/null

    if [ $? -ne 0 ]; then

        for i in $username;
        do 
            .add-user.sh $username 1005
            echo "Success. An account has been created for $username."      
        done

   else  echo "Denied. An account already exists for $username"

   fi