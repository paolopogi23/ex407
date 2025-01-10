import tarfile
import os
import subprocess
import argparse

# Function to extract package name and version from a .deb file
def get_package_info(deb_path):
    try:
        # Use dpkg-deb to extract package name and version
        result = subprocess.run(
            ["dpkg-deb", "--info", deb_path], capture_output=True, text=True
        )
        output = result.stdout

        # Extract Package and Version fields
        package_name = None
        package_version = None

        for line in output.splitlines():
            if line.startswith(" Package:"):
                package_name = line.split(":", 1)[1].strip()
            elif line.startswith(" Version:"):
                package_version = line.split(":", 1)[1].strip()

        if package_name and package_version:
            return f"{package_name} (= {package_version})"
    except Exception as e:
        print(f"Error extracting info from {deb_path}: {e}")

    return None

# Function to process a tar file and extract package info
def process_tar_file(tar_path, version, debian_dir):
    package_info_list = []
    try:
        with tarfile.open(tar_path, "r") as tar:
            for member in tar.getmembers():
                if member.name.endswith(".deb"):
                    # Extract the .deb file to a temporary location
                    extracted_path = tar.extractfile(member)
                    if extracted_path:
                        temp_file = f"/tmp/{os.path.basename(member.name)}"
                        with open(temp_file, "wb") as f:
                            f.write(extracted_path.read())

                        # Get package name and version
                        package_info = get_package_info(temp_file)
                        if package_info:
                            package_info_list.append(package_info)

                        # Remove the temporary file
                        os.remove(temp_file)

    except Exception as e:
        print(f"Error processing tar file {tar_path}: {e}")

    return package_info_list

# Function to create the control file
def create_control_file(control_path, package_info_list, version, tar_path):
    control_content = (
        "Package: baseos-update-release\n"
        "Maintainer: IDK\n"
        "Section: baseos\n"
        "Architecture: amd64\n"
        "Priority: standard\n"
        f"Version: {version}\n"
        f"Depends: {', '.join(package_info_list)}\n"
        "Description: BaseOS Generic Updates Release\n"
        f"Input file: {os.path.basename(tar_path)}"
    )

    with open(control_path, "w") as control_file:
        control_file.write(control_content)

# Function to build the Debian package
def build_debian_package(debian_dir, package_name, version, package_info_list, tar_path, output_dir):
    try:
        # Create the necessary directory structure
        os.makedirs(os.path.join(debian_dir, "DEBIAN"), exist_ok=True)
        os.makedirs(os.path.join(debian_dir, "usr/share/doc", package_name), exist_ok=True)

        # Create the control file
        control_path = os.path.join(debian_dir, "DEBIAN/control")
        create_control_file(control_path, package_info_list, version, tar_path)

        # Build the Debian package
        package_filename = f"{package_name}_{version}_amd64.deb"
        package_path = os.path.join(output_dir, package_filename)
        subprocess.run(
            ["dpkg-deb", "--build", debian_dir, package_path],
            check=True
        )
        print(f"Debian package created: {package_path}")
    except Exception as e:
        print(f"Error building Debian package: {e}")

# Main function
def main():
    parser = argparse.ArgumentParser(description="Create a Debian package from a tar file containing .deb packages.")
    parser.add_argument("tar_path", help="Path to the .tar file containing .deb packages")
    parser.add_argument("version", help="Version of the package")
    parser.add_argument(
        "--output", default="output", help="Directory for the output Debian package (default: output)"
    )

    args = parser.parse_args()
    tar_path = args.tar_path
    version = args.version
    output_dir = args.output

    if not os.path.exists(tar_path):
        print(f"File {tar_path} does not exist.")
        return

    debian_dir = "debian_package"
    package_info_list = process_tar_file(tar_path, version, debian_dir)

    # Build the Debian package
    build_debian_package(debian_dir, "baseos-update-release", version, package_info_list, tar_path, output_dir)

if __name__ == "__main__":
    main()
