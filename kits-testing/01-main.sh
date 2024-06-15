#!/bin/bash

KEY='test'
TEXT=$*

for cmd in $(ls -1 | grep $KEY ); do source $cmd ; done

step1 $TEXT
step2