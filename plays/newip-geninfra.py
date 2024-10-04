#!/usr/bin/env python3

import socket
import subprocess
import re

def get_hostname():
    return socket.gethostname()

def get_ip_address():
    # Using ip command to get all interfaces and their IPs
    try:
        output = subprocess.check_output("ip -4 -o addr show scope global", shell=True).decode('utf-8')
        # Find the first interface that starts with "en" or "eth" and exclude "docker0", "lo", and bridge interfaces
        match = re.search(r"(\d+): (en\w+|eth\w+)\s+inet (\S+)", output)
        if match:
            return match.group(3).split('/')[0]
        else:
            return None
    except Exception as e:
        return None

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

if __name__ == "__main__":
    config_file_path = '/opt/config/infrastructure.conf'
    write_hocon_config(config_file_path)
