#!/usr/bin/env python3

import socket
import netifaces
import psutil
from pyhocon import ConfigFactory, HOCONConverter
import os

# Function to get the hostname
def get_hostname():
    return socket.gethostname()

# Check if an interface is up using psutil
def is_interface_up(interface):
    stats = psutil.net_if_stats()
    return stats.get(interface, None) and stats[interface].isup

# Use netifaces to get the IP address of the first active Ethernet interface
def get_ip_address():
    for interface in netifaces.interfaces():
        # Only consider interfaces that start with 'en' or 'eth' and are up
        if (interface.startswith('en') or interface.startswith('eth')) and is_interface_up(interface):
            addrs = netifaces.ifaddresses(interface)

            # Check if the interface has an IPv4 address
            if netifaces.AF_INET in addrs:
                # Get the IPv4 address (first one)
                ip_address = addrs[netifaces.AF_INET][0]['addr']
                return ip_address
    return "unknown"

def main():
    # Get the hostname
    hostname = get_hostname()

    # Get the IP address
    ip_address = get_ip_address()

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

if __name__ == "__main__":
    main()
