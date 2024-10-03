#!/usr/bin/env python3

import json
import sys
import argparse
import os

def get_inventory(subnet):
    return {
        "all": {
            "hosts": {
                "host1": {
                    "ansible_host": f"{subnet}.200",
                    "subsystem_id": "h1-test"
                },
                "host2": {
                    "ansible_host": f"{subnet}.151"
                },
                "host3": {
                    "ansible_host": f"{subnet}.152"
                }
            }
        }
    }

def get_host_vars(hostname, subnet):
    hosts = get_inventory(subnet)["all"]["hosts"]
    return hosts.get(hostname, {})

def main():
    # Parse command line arguments
    parser = argparse.ArgumentParser(description="Ansible dynamic inventory script.")
    parser.add_argument('--list', action='store_true', help="List inventory")
    parser.add_argument('--host', help="Get all the variables about a specific host")
    parser.add_argument('--subnet', help="Subnet to use for the hosts")
    args = parser.parse_args()

    # Check for subnet from environment variable, command-line args, or default
    subnet = args.subnet or os.environ.get('INVENTORY_SUBNET', '192.168.1')

    if args.list:
        inventory = get_inventory(subnet)
        print(json.dumps(inventory, indent=2))
    elif args.host:
        host_vars = get_host_vars(args.host, subnet)
        print(json.dumps(host_vars, indent=2))
    else:
        parser.print_help()
        sys.exit(1)

if __name__ == "__main__":
    main()
