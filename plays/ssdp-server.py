from flask import Flask, request, jsonify
from ssdpy import SSDPServer
import threading

app = Flask(__name__)
current_ip = "192.168.1.10"  # Set the initial IP address

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

    current_ip = new_ip
    return jsonify({"message": "IP address updated successfully.", "new_ip": current_ip}), 200

def start_ssdp_server():
    # Set the USN and other parameters
    usn = "uuid:12345678-1234-5678-1234-567812345678::my_service"
    server = SSDPServer(usn, "my_service", "urn:my_service", "My SSDP Service")
    server.start()
    server.announce(f"http://{current_ip}:5000/change-ip", "ssdp:service:my_service", "urn:my_service")

if __name__ == '__main__':
    # Start the SSDP server in a separate thread
    ssdp_thread = threading.Thread(target=start_ssdp_server)
    ssdp_thread.daemon = True
    ssdp_thread.start()

    # Start the Flask server
    app.run(host='0.0.0.0', port=5000)
