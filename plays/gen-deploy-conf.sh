#!/bin/bash

# Function to display help message
print_help() {
    echo "Usage: $0 -c <CIDR> [-id <subsystem_id>] [-o <output_file>]"
    echo
    echo "Options:"
    echo "  -c, --cidr             CIDR notation for the network (e.g., 192.168.1.0/24)."
    echo "  -id, --subsystem_id     Subsystem ID (default: sys-h1-1000)."
    echo "  -o, --output            Output file path for the configuration (default: /opt/config/deploy-nuc.conf)."
    echo "  -h, --help              Show this help message."
    echo
    echo "Examples:"
    echo "  $0 -c 192.168.1.0/24"
    echo "  $0 --cidr 10.0.0.0/16 --subsystem_id my-system --output ./config/deploy-nuc.conf"
    exit 1
}

# Function to validate CIDR format and extract the first three octets
extract_three_octets() {
    local cidr="$1"
    # Use ipcalc to validate CIDR and extract the subnet address
    local subnet_info=$(ipcalc -n "$cidr" 2>/dev/null)

    if [[ $? -ne 0 ]]; then
        echo "Invalid CIDR format. Please provide a valid CIDR (e.g., 192.168.1.0/24)."
        exit 1
    fi

    # Extract the network address from ipcalc output
    local network_address=$(echo "$subnet_info" | grep "Network" | awk '{print $2}')

    # Extract the first three octets
    echo "${network_address%.*}"
}

# Default values
default_subsystem_id="sys-h1-1000"
default_output="/opt/config/deploy-nuc.conf"
docker_inv="offline-staging"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--cidr)
            cidr="$2"
            shift 2
            ;;
        -id|--subsystem_id)
            subsystem_id="$2"
            shift 2
            ;;
        -o|--output)
            output="$2"
            shift 2
            ;;
        -h|--help)
            print_help
            ;;
        *)
            echo "Invalid option: $1"
            print_help
            ;;
    esac
done

# Validate required arguments
if [[ -z "$cidr" ]]; then
    echo "CIDR notation is required. Use -c or --cidr."
    print_help
fi

# Extract the first three octets from the CIDR
system_subnet_ip=$(extract_three_octets "$cidr")

# Use default values if not set
subsystem_id="${subsystem_id:-$default_subsystem_id}"
output="${output:-$default_output}"

# Generate the deploy-nuc.conf file content
deploy_nuc_conf_content="docker_inv=${docker_inv}
system_subnet_ip=${system_subnet_ip}
subsystem_id=${subsystem_id}"

# Create the directory if it doesn't exist
mkdir -p "$(dirname "$output")"

# Write the configuration to the file
echo "$deploy_nuc_conf_content" > "$output"

echo "Configuration file created successfully at: $output"
