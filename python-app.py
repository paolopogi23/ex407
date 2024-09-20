from flask import Flask, request, jsonify
import os

app = Flask(__name__)

# Define the folder to save uploaded files
UPLOAD_FOLDER = './uploads'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# API to handle multiple file uploads
@app.route('/upload', methods=['POST'])
def upload_files():
    if 'files[]' not in request.files:
        return jsonify({"error": "No files part in the request"}), 400

    files = request.files.getlist('files[]')

    saved_files = []
    for file in files:
        if file.filename == '':
            return jsonify({"error": "One of the files has no filename"}), 400

        # Save the file to the defined folder
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
        file.save(file_path)
        saved_files.append(file.filename)

    return jsonify({"message": "Files successfully uploaded", "files": saved_files}), 200

# API to write content to a file
@app.route('/write-file', methods=['POST'])
def write_file():
    data = request.get_json()

    if not data or 'filename' not in data or 'content' not in data:
        return jsonify({"error": "Invalid data. 'filename' and 'content' required."}), 400

    file_path = os.path.join(app.config['UPLOAD_FOLDER'], data['filename'])
    
    # Write the content to the file
    with open(file_path, 'w') as f:
        f.write(data['content'])

    return jsonify({"message": f"File {data['filename']} written successfully"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
