#!/usr/bin/env python3

import psutil
import socket
from pyhocon import ConfigFactory, HOCONConverter
import os

# Get the hostname
hostname = socket.gethostname()

# Get network interfaces and their status
net_if_addrs = psutil.net_if_addrs()
net_if_stats = psutil.net_if_stats()

# Find the first Ethernet interface that is up (and not loopback)
ip_address = "unknown"
for interface, addrs in net_if_addrs.items():
    # Skip loopback interfaces and check if the interface is up
    if net_if_stats[interface].isup and not interface.startswith("lo"):
        for addr in addrs:
            if addr.family == 2:  # AF_INET (IPv4)
                ip_address = addr.address
                break
    if ip_address != "unknown":
        break

# Prepare the HOCON configuration
config_dict = {
    "host": {
        "hostname": hostname,
        "ip_address": ip_address
    },
    "include": [
        "infrastructure.d/product-type",
        "infrastructure.d/system-type"
    ]
}

# Create a HOCON configuration
config = ConfigFactory.from_dict(config_dict)

# Convert to HOCON string using HOCONConverter
hocon_output = HOCONConverter.to_hocon(config)

# Define the file path
file_path = "/opt/config/infrastructure.conf"

# Ensure the directory exists
os.makedirs(os.path.dirname(file_path), exist_ok=True)

# Write the configuration to the file
with open(file_path, "w") as config_file:
    config_file.write(hocon_output)

print(f"Configuration written to {file_path}")
