#!/bin/bash

set -e

USER="{{ user }}"
PASS="{{ pass }}"

if getent passwd "$USER" > /dev/null 2>&1; then
    echo "$USER already exists"
    exit 0
fi

echo "Creating user $USER..."
adduser --home /home/$USER --shell /bin/bash --disabled-password --gecos "" $USER

echo "Setting password for $USER..."
echo "$USER:$PASS" | chpasswd

echo "User $USER created successfully"

{% if ssh_public_key %}
echo "Configuring SSH key for $USER..."
mkdir -p /home/$USER/.ssh
echo "{{ ssh_public_key }}" >> /home/$USER/.ssh/authorized_keys
chmod 700 /home/$USER/.ssh
chmod 600 /home/$USER/.ssh/authorized_keys
chown -R $USER:$USER /home/$USER/.ssh
echo "SSH key configured"
{% endif %}
