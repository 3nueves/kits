#!/bin/bash

KEY='02|03'
TEXT="${1:-no args}"

for cmd in $(ls -1 | grep -E "$KEY"); do source "$cmd"; done

step1 "$TEXT"
step2