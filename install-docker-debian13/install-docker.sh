#!/bin/bash
set -euo pipefail

echo "=== Installing Docker Engine on Debian 13 (trixie) ==="

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "=== Adding Docker repository ==="
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

echo "=== Installing Docker packages ==="
sudo apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

echo "=== Enabling and starting docker service ==="
sudo systemctl enable --now docker

echo "=== Verifying installation ==="
DOCKER_VERSION=$(docker --version)
echo "DOCKER_VERSION=$DOCKER_VERSION"
echo "$DOCKER_VERSION"