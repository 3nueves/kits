#!/bin/bash

if [ -n "${1:-}" ]; then
  eval "$@"
else
  echo "Uso: ikctl -i cmd -p 'echo hello'"
fi