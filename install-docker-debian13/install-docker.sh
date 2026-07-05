#!/bin/bash
set -euo pipefail

echo "=== Installing Docker Engine on Debian 13 (trixie) ==="

apt-get update
apt-get install -y ca-certificates curl gnupg

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo "=== Adding Docker repository ==="
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

echo "=== Installing Docker packages ==="
apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

echo "=== Enabling and starting docker service ==="
systemctl enable --now docker

echo "=== Verifying installation ==="
DOCKER_VERSION=$(docker --version)
echo "DOCKER_VERSION=$DOCKER_VERSION"
echo "$DOCKER_VERSION"