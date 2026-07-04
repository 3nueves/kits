#!/bin/bash
set -euo pipefail

# Uso: ikctl -i create-user -p USER=miuser PASS=mipass SSH_KEY="ssh-ed25519 AAAA... user@host"
# SSH_KEY es opcional — si se omite, solo se crea el usuario con contraseña

USER="${USER:-}"
PASS="${PASS:-}"
SSH_KEY="${SSH_KEY:-}"

if [ -z "$USER" ]; then
  echo "Error: USER es obligatorio. Usa -p USER=nombre"
  exit 1
fi

if [ -z "$PASS" ]; then
  echo "Error: PASS es obligatorio. Usa -p PASS=contraseña"
  exit 1
fi

# Si el usuario ya existe, salir
if getent passwd "$USER" > /dev/null 2>&1; then
  echo "USER_CREATED=$USER"
  echo "El usuario $USER ya existe"
  exit 0
fi

echo "Creando usuario $USER..."
adduser --home "/home/$USER" --shell /bin/bash --disabled-password --gecos "" "$USER"

echo "Configurando contraseña..."
echo "$USER:$PASS" | chpasswd

if [ -n "$SSH_KEY" ]; then
  echo "Configurando clave SSH para $USER..."
  mkdir -p "/home/$USER/.ssh"
  echo "$SSH_KEY" >> "/home/$USER/.ssh/authorized_keys"
  chmod 700 "/home/$USER/.ssh"
  chmod 600 "/home/$USER/.ssh/authorized_keys"
  chown -R "$USER:$USER" "/home/$USER/.ssh"
  echo "Clave SSH configurada"
fi

echo "Configurando sudo sin contraseña..."
echo "$USER ALL=(ALL) NOPASSWD: ALL" >> "/etc/sudoers.d/$USER"
chmod 440 "/etc/sudoers.d/$USER"
usermod -aG sudo "$USER"
echo "Usuario $USER añadido a sudoers"

echo "USER_CREATED=$USER"
echo "Usuario $USER creado correctamente"