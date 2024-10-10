import psutil
import socket
import os
from pyhocon import ConfigFactory, HOCONConverter

def get_first_active_ethernet_interface():
    """
    Identifies the first active Ethernet interface that is up and has an IP address.
    Excludes loopback, Docker, and bridge interfaces.
    Returns the IP address if found.
    """
    interfaces = psutil.net_if_addrs()
    stats = psutil.net_if_stats()

    # Ethernet-like interface name prefixes
    ethernet_prefixes = ('eth', 'en', 'em', 'ens', 'eno')  # Common Ethernet prefixes
    exclude_prefixes = ('docker', 'br', 'lo')  # Exclude docker, bridge, and loopback

    for interface_name, addrs in interfaces.items():
        # Exclude unwanted interfaces by name
        if interface_name.startswith(exclude_prefixes):
            continue
        
        # Only allow Ethernet interfaces by matching the name prefixes
        if not interface_name.startswith(ethernet_prefixes):
            continue

        # Check if the interface is up and has an IPv4 address
        if stats[interface_name].isup:
            for addr in addrs:
                if addr.family == socket.AF_INET and addr.address != '127.0.0.1':  # Exclude loopback IP
                    return interface_name, addr.address

    return None, None

def get_hostname():
    """
    Retrieves the system's hostname.
    """
    return socket.gethostname()

def write_to_hocon_file(filepath, hostname, ip_address):
    """
    Writes the hostname and IP address to the specified file in HOCON format.
    """
    # Ensure the directory exists
    os.makedirs(os.path.dirname(filepath), exist_ok=True)

    # Create HOCON configuration tree
    config = ConfigFactory.parse_string("""
    host {
        hostname: ""
        ip_address: ""
    }
    include "infrastructure.d/product-type.conf"
    include "infrastructure.d/system-type.conf"
    """)

    # Update hostname and IP address dynamically
    config['host.hostname'] = hostname
    config['host.ip_address'] = ip_address

    # Convert config tree to HOCON format and write to file
    with open(filepath, 'w') as file:
        file.write(HOCONConverter.to_hocon(config))

def main():
    # Get the first active Ethernet interface's IP and the hostname
    interface, ip_address = get_first_active_ethernet_interface()
    hostname = get_hostname()

    if ip_address:
        # Filepath to write the configuration
        filepath = '/opt/config/infrastructure.conf'
        # Write to the file in HOCON format
        write_to_hocon_file(filepath, hostname, ip_address)
        print(f"Configuration written to {filepath}")
    else:
        print("No active Ethernet interface with an IP address found.")

if __name__ == "__main__":
    main()
