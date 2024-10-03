#!/usr/bin/env python3

import json
import sys
import argparse
import ipaddress

def validate_subnet(subnet):
    try:
        # Ensure the subnet is a valid network with CIDR notation
        network = ipaddress.ip_network(subnet, strict=False)
        return network.network_address, network.prefixlen  # Return network address and the prefix length
    except ValueError:
        print(f"Error: '{subnet}' is not a valid CIDR range.")
        sys.exit(1)

def get_inventory(subnet, subnet_mask, subsystem_id):
    subnet_base = str(subnet).rsplit('.', 1)[0]  # Get the base of the subnet (e.g., '192.168.1')

    # Default value for network_nameserver
    network_nameserver = "10.10.110.80"

    return {
        "all": {
            "hosts": {
                "provisioning-host": {
                    "ansible_host": f"{subnet_base}.150",
                    "subsystem_id": subsystem_id,
                    "server_hostname": "nuc",
                    "interface_gateway": f"{subnet_base}.2",
                    "interface_ip": f"{subnet_base}.150",
                    "interface_mask": 24,
                    "subnet_mask": "255.255.255.0",
                    "create_gateway_route": False,
                    "mtu_size": 9000
                },
                "application-vm": {
                    "ansible_host": f"{subnet_base}.151",
                    "subsystem_id": subsystem_id,
                    "vm_disk_size": "150GB",
                    "vm_memory_size": "16GB",
                    "vm_vcpu": 6,
                    "server_hostname": "application-vm",
                    "vm_domain_name": "{{ server_hostname }}",
                    "create_gateway_route": False,
                    "interface_gateway": f"{subnet_base}.1",
                    "interface_mask": 24,
                    "interface_ip": f"{subnet_base}.151",
                    "subnet_mask": "255.255.255.0",
                    "wifi_enable": True
                },
                "gateway-vm": {
                    "ansible_host": f"{subnet_base}.1",
                    "subsystem_id": subsystem_id,
                    "vm_disk_size": "100GB",
                    "vm_memory_size": "8GB",
                    "vm_vcpu": 4,
                    "interface_ip": f"{subnet_base}.1",
                    "interface_mask": 16,
                    "interface_gateway": f"{subnet_base}.2",
                    "subnet_mask": "255.255.255.0",
                    "server_hostname": "gw-vm",
                    "vm_domain_name": "{{ server_hostname }}",
                    "interface_nameserver": network_nameserver,
                    "create_gateway_route": True
                },
                "scanner-vm": {
                    "ansible_host": f"{subnet_base}.152",
                    "subsystem_id": subsystem_id,
                    "vm_disk_size": "90GB",
                    "vm_memory_size": "8GB",
                    "vm_vcpu": 4,
                    "interface_ip": f"{subnet_base}.152",
                    "interface_gateway": f"{subnet_base}.1",
                    "interface_mask": 16,
                    "interface_nameserver": network_nameserver,
                    "autounattend": "{{ packer_dir }}/Autounattend.xml",
                    "disk_size": "40960",
                    "disk_type_id": "1",
                    "headless": "false",
                    "restart_timeout": "5m",
                    "ansible_user": "sysadm",
                    "ansible_password": "{{ vault_ansible_password }}"  # Encrypted password
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

    # Validate subnet CIDR and get the subnet mask (prefix length)
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
