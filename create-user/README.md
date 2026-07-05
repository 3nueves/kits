# create-user

Crea un usuario en el servidor remoto con contraseña, clave SSH opcional y sudo sin contraseña.

## Uso

```bash
# Usuario + contraseña
ikctl -i create-user -p USER=miuser PASS=secreta

# Usuario + contraseña + clave SSH
ikctl -i create-user -p USER=miuser PASS=secreta SSH_KEY="ssh-ed25519 AAAAC3Nza... user@host"

# Con sudo (necesario para adduser, chpasswd, sudoers)
ikctl -i create-user -s sudo -p USER=miuser PASS=secreta

# Todo junto
ikctl -i create-user -s sudo -p USER=miuser PASS=secreta SSH_KEY="ssh-ed25519 AAAAC3Nza... user@host"
```

## Parámetros

| Parámetro | Obligatorio | Descripción |
|-----------|-------------|-------------|
| `USER`    | Sí          | Nombre del usuario a crear |
| `PASS`    | Sí          | Contraseña del usuario |
| `SSH_KEY` | No          | Clave pública SSH completa (`ssh-ed25519 AAAA...` o `ssh-rsa AAAA...`) |

## Qué hace

1. Verifica si el usuario ya existe (si existe, sale sin error)
2. Crea el usuario con `adduser` (home en `/home/<user>`, shell `/bin/bash`)
3. Configura la contraseña con `chpasswd`
4. Si `SSH_KEY` está definido, configura `authorized_keys` con permisos correctos
5. Añade el usuario a sudoers con `NOPASSWD: ALL`
6. Añade el usuario al grupo `sudo`

## Notas

- Requiere ejecutarse como root o con `-s sudo`
- Si el usuario ya existe, no se modifica — solo reporta que existe
- `SSH_KEY` debe ser la clave pública completa, no una ruta de fichero