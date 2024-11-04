#!/usr/bin/env python3

import socket
import subprocess
import re
import os

def get_hostname():
    full_hostname = socket.gethostname()
    first_two_fields = "-".join(full_hostname.split("-")[:2])
    return first_two_fields

def get_ip_address():
    try:
        output = subprocess.check_output("ip -4 -o addr show scope global", shell=True).decode('utf-8')
        match = re.search(r"(\d+): (en\w+|eth\w+)\s+inet (\S+)", output)
        if match:
            return match.group(3).split('/')[0]
        else:
            return None
    except Exception as e:
        return None

def get_subnet_and_netmask():
    try:
        output = subprocess.check_output("ip -4 -o addr show scope global", shell=True).decode('utf-8')
        match = re.search(r"(\d+): (en\w+|eth\w+)\s+inet (\S+)/(\d+)", output)
        if match:
            ip_address = match.group(3)
            prefix_length = int(match.group(4))

            # Convert prefix length to subnet mask
            netmask = (0xffffffff >> (32 - prefix_length)) << (32 - prefix_length)
            netmask_str = f"{(netmask >> 24) & 255}.{(netmask >> 16) & 255}.{(netmask >> 8) & 255}.{netmask & 255}"

            # Calculate the subnet
            ip_parts = list(map(int, ip_address.split('.')))
            netmask_parts = list(map(int, netmask_str.split('.')))
            subnet_parts = [ip_parts[i] & netmask_parts[i] for i in range(4)]
            subnet_str = ".".join(map(str, subnet_parts))

            return subnet_str, netmask_str
        else:
            return None, None
    except Exception as e:
        return None, None

def write_hocon_config(file_path):
    hostname = get_hostname()
    ip_address = get_ip_address()

    if ip_address is None:
        ip_address = "unknown"

    hocon_format = f"""host {{
    hostname: "{hostname}",
    ip_address: "{ip_address}"
}}
include "infrastructure.d/product-type.conf"
include "infrastructure.d/system-type.conf"
"""

    try:
        with open(file_path, 'w') as config_file:
            config_file.write(hocon_format)
        print(f"Configuration written to {file_path}")
    except Exception as e:
        print(f"Failed to write to {file_path}: {e}")

def create_product_type_config(file_path):
    subnet, netmask = get_subnet_and_netmask()

    if subnet is None or netmask is None:
        print("Failed to retrieve subnet and netmask")
        return

    product_type_content = f"""system {{
    subnet: {subnet}
    netmask: {netmask}
}}"""

    # Ensure the directory exists
    os.makedirs(os.path.dirname(file_path), exist_ok=True)

    try:
        with open(file_path, 'w') as product_file:
            product_file.write(product_type_content)
        print(f"Product-type configuration written to {file_path}")
    except Exception as e:
        print(f"Failed to write to {file_path}: {e}")

if __name__ == "__main__":
    config_file_path = '/opt/config/infrastructure.conf'
    product_type_file_path = '/opt/config/infrastructure.d/product-type.conf'
    
    write_hocon_config(config_file_path)
    create_product_type_config(product_type_file_path)
