#!/bin/bash

# Define the file path
config_file="/var/tmp/deploy-nuc.conf"

# Check if the file exists and contains the docker_inv entry
if [ -f "$config_file" ] && docker_inv_value=$(grep -m 1 "^docker_inv=" "$config_file" | cut -d'=' -f2) && [ -n "$docker_inv_value" ]; then
    echo "docker_inv is set to: $docker_inv_value"
else
    echo "Either the file does not exist, docker_inv is not defined, or it has no value."
    echo "=============================="
    echo
    echo "see output below of $config_file"
    cat $config_file
fi

==================================

root@ubuntu20-original:/home/juan# cat /var/tmp/deploy-nuc.conf
docker_inv=

root@ubuntu20-original:/home/juan# ./check-file.sh
Either the file does not exist, docker_inv is not defined, or it has no value.

===================================

root@ubuntu20-original:/home/juan# cat /var/tmp/deploy-nuc.conf
docker_inv=h1-77

root@ubuntu20-original:/home/juan# ./check-file.sh
docker_inv is set to: h1-77
