import json
import requests
from ssdp import SSDPClient

def discover_servers():
    client = SSDPClient()
    devices = client.discover()
    return devices

def change_ip(server_url, new_ip):
    try:
        response = requests.post(server_url, json={"new_ip": new_ip})
        if response.status_code == 200:
            print(f"Successfully changed IP to: {response.json()['new_ip']}")
        else:
            print(f"Error: {response.json()['error']}")
    except requests.exceptions.RequestException as e:
        print(f"Failed to connect to the server: {e}")

if __name__ == '__main__':
    print("Discovering SSDP servers...")
    discovered_devices = discover_servers()

    # List discovered devices
    for idx, device in enumerate(discovered_devices):
        print(f"{idx + 1}: {device}")

    # Assuming the first discovered device is the server
    if discovered_devices:
        server_device = discovered_devices[0]
        server_url = f"http://{server_device.address}:5000/change-ip"

        # Change the IP address
        new_ip = "192.168.1.20"  # Desired new IP address
        change_ip(server_url, new_ip)
    else:
        print("No SSDP servers found.")
