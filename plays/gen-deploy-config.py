#!/usr/bin/env python3

import argparse
import os
import ipaddress

def extract_three_octets(cidr):
    """Extract the first three octets from a CIDR notation."""
    try:
        network = ipaddress.ip_network(cidr, strict=False)
        return str(network.network_address).rsplit('.', 1)[0]  # Get the first three octets
    except ValueError:
        return None

def main():
    # Set up argument parser with shortcuts
    parser = argparse.ArgumentParser(description="Generate a deploy-nuc.conf configuration file.")
    parser.add_argument(
        "-c", "--cidr",
        type=str,
        required=True,
        help="CIDR notation for the network (e.g., 192.168.1.0/24)."
    )
    parser.add_argument(
        "-id", "--subsystem_id",
        type=str,
        default="sys-h1-1000",  # Default value for subsystem_id
        help="Subsystem ID (default: sys-h1-1000)."
    )
    parser.add_argument(
        "-o", "--output",
        type=str,
        default='/opt/config/deploy-nuc.conf',
        help="Output file path for the configuration (default: /opt/config/deploy-nuc.conf)."
    )

    # Parse arguments
    args = parser.parse_args()

    # Extract the first three octets from the CIDR
    system_subnet_ip = extract_three_octets(args.cidr)
    if system_subnet_ip is None:
        print("Invalid CIDR format. Please provide a valid CIDR (e.g., 192.168.1.0/24).")
        return

    # Default value for docker_inv
    docker_inv = "offline-staging"

    # Generate the deploy-nuc.conf file content
    deploy_nuc_conf_content = f"""docker_inv={docker_inv}
system_subnet_ip={system_subnet_ip}
subsystem_id={args.subsystem_id}
"""

    # Specify the file path
    config_file_path = args.output

    # Create the directory if it doesn't exist
    os.makedirs(os.path.dirname(config_file_path), exist_ok=True)

    # Write the configuration to the file
    with open(config_file_path, 'w') as config_file:
        config_file.write(deploy_nuc_conf_content)

    print(f"Configuration file created successfully at: {config_file_path}")

if __name__ == "__main__":
    main()
