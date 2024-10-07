#!/usr/bin/env python3

import argparse
import os
import glob
import ipaddress
import netifaces

def clean_old_netplan_configs():
    """Rename existing netplan files in /etc/netplan."""
    netplan_files = glob.glob("/etc/netplan/*.yaml")

    if netplan_files:
        print(f"Found existing netplan files: {netplan_files}")
        for file in netplan_files:
            os.rename(file, file + ".bak")
            print(f"Renamed {file} to {file}.bak")
    else:
        print("No existing netplan files found.")

def validate_ip(address):
    """Validate the given IP address and CIDR notation."""
    try:
        ipaddress.ip_network(address, strict=False)
        return True
    except ValueError:
        return False

def get_first_active_interface():
    """Get the first active network interface."""
    interfaces = netifaces.interfaces()
    for interface in interfaces:
        # Check if the interface is up
        operstate_path = f'/sys/class/net/{interface}/operstate'
        if os.path.exists(operstate_path):
            with open(operstate_path) as f:
                operstate = f.read().strip()
                if operstate == 'up':
                    # Get the addresses for the interface
                    addrs = netifaces.ifaddresses(interface)
                    if netifaces.AF_INET in addrs:
                        return interface  # Return the first active interface
    return None  # Return None if no active interface is found

def generate_netplan_yaml(interface, address, gateway, dns, filename, use_nm_renderer):
    """Generate netplan YAML configuration file."""
    renderer = "NetworkManager" if use_nm_renderer else "networkd"

    # Convert DNS list to YAML format (each DNS entry on a new line with proper indentation)
    dns_entries = "\n".join([f"          - {dns_entry}" for dns_entry in dns])

    netplan_template = f"""
network:
  version: 2
  renderer: {renderer}
  ethernets:
    {interface}:
      dhcp4: no
      addresses:
        - {address}
      gateway4: {gateway}
      nameservers:
        addresses:
{dns_entries}
    """
    # Write to the netplan YAML file
    with open(filename, 'w') as file:
        file.write(netplan_template.strip())

def main():
    # Default values
    default_ip = '192.168.1.10/24'
    default_gateway = '192.168.1.1'
    default_dns = ['8.8.8.8', '8.8.4.4']  # Default to multiple DNS addresses
    default_filename = '/etc/netplan/99-static-config.yaml'  # Use a higher number for precedence

    # Get the first active interface
    detected_interface = get_first_active_interface()
    if detected_interface:
        print(f"Detected first active interface: {detected_interface}")
    else:
        print("No active network interface found. Exiting.")
        return

    # Setup argument parser
    parser = argparse.ArgumentParser(description="Create a netplan file with static IP configuration.")

    # Define the arguments with default values and descriptions
    parser.add_argument('--interface', help="The network interface to configure", default=detected_interface)
    parser.add_argument('--address', help="The static IP address in CIDR notation (e.g., 192.168.1.10/24)", default=default_ip)
    parser.add_argument('--gateway', help="The gateway IP address", default=default_gateway)
    parser.add_argument('--dns', nargs='+', help="DNS server addresses (space-separated for multiple)", default=default_dns)
    parser.add_argument('--filename', help="The output filename for the netplan config", default=default_filename)
    parser.add_argument('--use_nm', help="Use NetworkManager as the renderer", action='store_true')

    args = parser.parse_args()

    # Validate the IP address
    if not validate_ip(args.address):
        print(f"Error: The IP address '{args.address}' is not valid. Please provide a valid CIDR notation.")
        return

    # Print out the configuration for confirmation
    print(f"Creating netplan config:")
    print(f"  Interface: {args.interface}")
    print(f"  IP Address: {args.address}")
    print(f"  Gateway: {args.gateway}")
    print(f"  DNS: {', '.join(args.dns)}")
    print(f"  Renderer: {'NetworkManager' if args.use_nm else 'networkd'}")
    print(f"  Output file: {args.filename}")

    # Clean up old netplan configs
    clean_old_netplan_configs()

    # Generate the netplan configuration file with the selected renderer
    generate_netplan_yaml(args.interface, args.address, args.gateway, args.dns, args.filename, args.use_nm)

    # Feedback to the user
    print(f"Netplan configuration written to {args.filename}")

    # Optionally apply the netplan
    apply_netplan = input("Would you like to apply the configuration now? (yes/no): ").strip().lower()
    if apply_netplan == 'yes':
        os.system('sudo netplan apply')
        print("Netplan configuration applied successfully.")
    else:
        print("Netplan configuration was created but not applied.")

if __name__ == "__main__":
    main()
