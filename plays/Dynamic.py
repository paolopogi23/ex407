#!/usr/bin/env python3

import json
import sys
import argparse

def get_inventory(subnet, subsystem_id):
    return {
        "all": {
            "hosts": {
                "host1": {
                    "ansible_host": f"{subnet}.150",
                    "subsystem_id": subsystem_id,
                    "cpu": 6,
                    "memory": "16GB",
                    "interface_ip": f"{subnet}.150",  # sourced from ansible_host
                    "interface_gw": f"{subnet}.1"
                },
                "host2": {
                    "ansible_host": f"{subnet}.151",
                    "subsystem_id": subsystem_id,
                    "cpu": 4,
                    "memory": "8GB",
                    "interface_ip": f"{subnet}.151",  # sourced from ansible_host
                    "interface_gw": f"{subnet}.1"
                },
                "host3": {
                    "ansible_host": f"{subnet}.152",
                    "subsystem_id": subsystem_id,
                    "cpu": 4,
                    "memory": "8GB",
                    "interface_ip": f"{subnet}.152",  # sourced from ansible_host
                    "interface_gw": f"{subnet}.1"
                }
            }
        }
    }

def get_host_vars(hostname, subnet, subsystem_id):
    hosts = get_inventory(subnet, subsystem_id)["all"]["hosts"]
    return hosts.get(hostname, {})

def main():
    # Default values for subnet and subsystem_id
    default_subnet = '192.168.1'
    default_subsystem_id = 'h1-1000'

    # Parse command line arguments
    parser = argparse.ArgumentParser(description="Ansible dynamic inventory script.")
    parser.add_argument('--list', action='store_true', help="List inventory")
    parser.add_argument('--host', help="Get all the variables about a specific host")
    parser.add_argument('--subnet', help="Override the subnet", default=default_subnet)  # Default is '192.168.1'
    parser.add_argument('--subsystem_id', help="Override the subsystem_id", default=default_subsystem_id)  # Default is 'unknown'
    args = parser.parse_args()

    # Use command line args or defaults
    subnet = args.subnet
    subsystem_id = args.subsystem_id

    if args.list:
        inventory = get_inventory(subnet, subsystem_id)
        print(json.dumps(inventory, indent=2))
    elif args.host:
        host_vars = get_host_vars(args.host, subnet, subsystem_id)
        print(json.dumps(host_vars, indent=2))
    else:
        parser.print_help()
        sys.exit(1)

if __name__ == "__main__":
    main()
