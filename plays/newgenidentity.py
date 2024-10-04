#!/usr/bin/env python3

import subprocess
import socket
import os

def get_hostname():
    return socket.gethostname()

def is_virtual_machine():
    # Check if the system is a virtual machine
    try:
        output = subprocess.check_output("dmidecode -s system-product-name", shell=True).decode().strip()
        return output.lower() in ["virtualbox", "qemu", "vmware", "xen", "hyper-v"]
    except Exception:
        return False

def get_serial_or_uuid():
    try:
        # Retrieve the product name for both physical and virtual machines
        product_name = subprocess.check_output("dmidecode -s system-product-name", shell=True).decode().strip()

        if is_virtual_machine():
            # Return the system UUID for virtual machines
            uuid = subprocess.check_output("dmidecode -s system-uuid", shell=True).decode().strip()
            return {"type": "virtual", "uuid": uuid, "product_name": product_name}
        else:
            # Return the serial number for physical machines
            serial_number = subprocess.check_output("dmidecode -s system-serial-number", shell=True).decode().strip()
            return {"type": "physical", "serial_number": serial_number, "product_name": product_name}
    except Exception as e:
        return {"type": "unknown", "error": str(e)}

def write_hocon_config(file_path, hostname, system_info):
    # Construct the HOCON formatted string
    identifier = system_info.get("uuid") or system_info.get("serial_number", "unknown")
    product_name = system_info.get("product_name", "unknown")

    hocon_format = f"""host {{
    hostname: "{hostname}",
    type: "{system_info.get('type', 'unknown')}",
    identifier: "{identifier}",
    product_name: "{product_name}"
}}
include "infrastructure.d/product-type.conf"
include "infrastructure.d/system-type.conf"
"""

    # Ensure the directory exists
    os.makedirs(os.path.dirname(file_path), exist_ok=True)

    # Write the configuration to the file
    with open(file_path, "w") as config_file:
        config_file.write(hocon_format)

    print(f"Configuration written to {file_path}")

def main():
    # Get the hostname
    hostname = get_hostname()

    # Get the serial number or UUID
    system_info = get_serial_or_uuid()

    # Define the file path for identity information
    file_path = "/opt/config/identity.conf"

    # Write the HOCON configuration
    write_hocon_config(file_path, hostname, system_info)

if __name__ == "__main__":
    main()
