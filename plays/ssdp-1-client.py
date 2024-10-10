import socket
import json
import requests

def discover_servers():
    # Create a UDP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    sock.settimeout(2)

    # SSDP M-SEARCH request
    ssdp_request = (
        'M-SEARCH * HTTP/1.1\r\n'
        'HOST: 239.255.255.250:1900\r\n'
        'MAN: "ssdp:discover"\r\n'
        'MX: 1\r\n'
        'ST: ssdp:all\r\n'
        '\r\n'
    )

    # Send the SSDP request
    sock.sendto(ssdp_request.encode('utf-8'), ('239.255.255.250', 1900))

    # Listen for responses
    devices = []
    try:
        while True:
            data, addr = sock.recvfrom(1024)
            devices.append((data.decode('utf-8'), addr[0]))
    except socket.timeout:
        pass

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
    for idx, (data, address) in enumerate(discovered_devices):
        print(f"{idx + 1}: Address: {address}, Data: {data}")

    # Assuming the first discovered device is the server
    if discovered_devices:
        # Parse the first device's address to form the server URL
        server_address = discovered_devices[0][1]
        server_url = f"http://{server_address}:5000/change-ip"

        # Change the IP address
        new_ip = "192.168.1.20"  # Desired new IP address
        change_ip(server_url, new_ip)
    else:
        print("No SSDP servers found.")
