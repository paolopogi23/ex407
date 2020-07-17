#!/bin/bash

if [ -n "$1" ];then
echo installing
ansible servers  -b -i ../inventory -m yum -a "name=${1} state=present"
else
echo no line argument provided
exit 1
fi
