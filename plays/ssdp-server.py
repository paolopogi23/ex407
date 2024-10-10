from flask import Flask, request, jsonify
from ssdpy import SSDPServer
import threading
import uuid
import subprocess

app = Flask(__name__)
current_ip = "192.168.1.10"  # Set your server's initial IP address here

@app.route('/change-ip', methods=['POST'])
def change_ip():
    global current_ip
    data = request.get_json()
    if not data or 'new_ip' not in data:
        return jsonify({"error": "Invalid request, 'new_ip' missing."}), 400

    new_ip = data['new_ip']

    # Validate the IP address format
    parts = new_ip.split(".")
    if len(parts) != 4 or not all(part.isdigit() and 0 <= int(part) <= 255 for part in parts):
        return jsonify({"error": "Invalid IP address format."}), 400

    # Attempt to change the IP address
    try:
        # Example for Linux using nmcli; adjust according to your OS and network manager
        # This is a placeholder command; actual implementation will vary
        # subprocess.run(["nmcli", "con", "modify", "Wired connection 1", "ipv4.addresses", new_ip], check=True)
        # For demonstration, we'll just update the variable without changing the actual IP
        current_ip = new_ip
        return jsonify({"message": "IP address updated successfully.", "new_ip": current_ip}), 200
    except subprocess.CalledProcessError as e:
        return jsonify({"error": f"Failed to change IP address: {e}"}), 500

def start_ssdp_server():
    # Generate a unique USN using UUID
    usn = f"uuid:{uuid.uuid4()}::urn:schemas-upnp-org:service:IPConfig:1"
    service_type = "urn:schemas-upnp-org:service:IPConfig:1"
    server_description = "IP Configuration Service"

    # Initialize SSDP server
    server = SSDPServer(usn, service_type, "urn:schemas-upnp-org:service:IPConfig:1", server_description)
    server.start()

    # Announce the service
    announce_url = f"http://{current_ip}:5000/change-ip"
    server.announce(announce_url, service_type, usn)

if __name__ == '__main__':
    # Start SSDP server in a separate thread
    ssdp_thread = threading.Thread(target=start_ssdp_server, daemon=True)
    ssdp_thread.start()

    # Start Flask server
    app.run(host='0.0.0.0', port=5000)
