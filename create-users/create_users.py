import os
import subprocess
import sys
import getpass

def add_user():

    users = {
		'user1': {
            'user': os.environ["user"],
            'pass': os.environ["pass"],
            'uid': os.environ["uid"]
        },
		'user2':{
			
        }
    }

	# Ask for the input
	username = input("Enter Username ") 

	# Asking for users password
	password = getpass.getpass()
		
	try:
		# executing useradd command using subprocess module
		subprocess.run(['useradd', '-p', password, username ])	 
	except:
		print(f"Failed to add user.")					 
		sys.exit(1)

add_user()
