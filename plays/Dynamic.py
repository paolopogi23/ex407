#!/usr/bin/env python3

import sys
import os

# Get the subnet and subsystem_id from environment variables or command line
subnet = os.getenv('subnet', "192.168.1")
subsystem_id = os.getenv('subsystem_id', "h1-77")

# Define the VM names and their corresponding last octets
vms = {
    "provisioning-vm": 150,
    "gw-vm": 151,
    "scanner-vm": 152,
    "application-vm": 153
}

# Print the inventory in INI format
for vm, last_octet in vms.items():
    ip_address = f"{subnet}.{last_octet}"
    print(f"[{vm}]")
    print(f"{vm} ansible_host={ip_address}")

# Print the vars section
print("\n[vars]")
print(f"subsystem_id={subsystem_id}")
