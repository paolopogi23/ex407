#!/usr/bin/env python3

import json
import sys
import argparse
import ipaddress

def validate_subnet(subnet):
    try:
        # Ensure the subnet is a valid network with CIDR notation
        network = ipaddress.ip_network(subnet, strict=False)
        return network.network_address, network.netmask  # Return both network address and mask
    except ValueError:
        print(f"Error: '{subnet}' is not a valid CIDR range.")
        sys.exit(1)

def get_inventory(subnet, subnet_mask, subsystem_id):
    subnet_base = str(subnet).rsplit('.', 1)[0]  # Get the base of the subnet (e.g., '192.168.1')
    return {
        "all": {
            "hosts": {
                "provisioning-vm": {
                    "ansible_host": f"{subnet_base}.100",
                    "subsystem_id": subsystem_id
                },
                "application-vm": {
                    "ansible_host": f"{subnet_base}.150",
                    "subsystem_id": subsystem_id,
                    "cpu": 6,
                    "memory": "16GB",
                    "interface_ip": f"{subnet_base}.150",  # sourced from ansible_host
                    "interface_gw": f"{subnet_base}.1",
                    "interface_mask": str(subnet_mask)  # Add mask from validated subnet
                },
                "gateway-vm": {
                    "ansible_host": f"{subnet_base}.151",
                    "subsystem_id": subsystem_id,
                    "cpu": 4,
                    "memory": "8GB",
                    "interface_ip": f"{subnet_base}.151",  # sourced from ansible_host
                    "interface_gw": f"{subnet_base}.1",
                    "interface_mask": str(subnet_mask)  # Add mask from validated subnet
                },
                "scanner-vm": {
                    "ansible_host": f"{subnet_base}.152",
                    "subsystem_id": subsystem_id,
                    "cpu": 4,
                    "memory": "8GB",
                    "interface_ip": f"{subnet_base}.152",  # sourced from ansible_host
                    "interface_gw": f"{subnet_base}.1",
                    "interface_mask": str(subnet_mask)  # Add mask from validated subnet
                }
            }
        }
    }

def get_host_vars(hostname, subnet, subnet_mask, subsystem_id):
    hosts = get_inventory(subnet, subnet_mask, subsystem_id)["all"]["hosts"]
    return hosts.get(hostname, {})

def main():
    # Default values for subnet and subsystem_id
    default_subnet = '192.168.1.0/24'
    default_subsystem_id = 'h1-1000'

    # Parse command line arguments
    parser = argparse.ArgumentParser(description="Ansible dynamic inventory script.")
    parser.add_argument('--list', action='store_true', help="List inventory")
    parser.add_argument('--host', help="Get all the variables about a specific host")
    parser.add_argument('--subnet', help="Override the subnet", default=default_subnet)  # Default is '192.168.1.0/24'
    parser.add_argument('--subsystem_id', help="Override the subsystem_id", default=default_subsystem_id)  # Default is 'unknown'
    args = parser.parse_args()

    # Validate subnet CIDR and get the subnet mask
    subnet, subnet_mask = validate_subnet(args.subnet)
    subsystem_id = args.subsystem_id

    if args.list:
        inventory = get_inventory(subnet, subnet_mask, subsystem_id)
        print(json.dumps(inventory, indent=2))
    elif args.host:
        host_vars = get_host_vars(args.host, subnet, subnet_mask, subsystem_id)
        print(json.dumps(host_vars, indent=2))
    else:
        parser.print_help()
        sys.exit(1)

if __name__ == "__main__":
    main()
