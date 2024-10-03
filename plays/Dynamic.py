#!/usr/bin/env python3

import json
import sys
import argparse

def load_config(config_file):
    config = {}
    with open(config_file) as f:
        for line in f:
            if '=' in line:
                key, value = line.strip().split('=', 1)
                config[key] = value
    return config

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
    # Load the configuration from source.conf
    config_file = 'source.conf'
    config = load_config(config_file)

    # Extract the subnet and subsystem_id from the config
    subnet = config.get('subnet', '192.168.1')
    subsystem_id = config.get('subsystem_id', 'unknown')

    # Parse command line arguments
    parser = argparse.ArgumentParser(description="Ansible dynamic inventory script.")
    parser.add_argument('--list', action='store_true', help="List inventory")
    parser.add_argument('--host', help="Get all the variables about a specific host")
    parser.add_argument('--subnet', help="Override the subnet")  # Add subnet argument
    parser.add_argument('--subsystem_id', help="Override the subsystem_id")  # Add subsystem_id argument
    args = parser.parse_args()

    # Override with command line args if provided
    if args.subnet:
        subnet = args.subnet
    if args.subsystem_id:
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
