#!/usr/bin/python3
import argparse
import subprocess
import os

def sync_files(user, ssh_key, source, temp_dir, target, host):
    # Step 1: Rsync the files to a temporary directory on the remote system
    rsync_command = [
        "rsync", "-avz", "--progress", 
        "-e", f"ssh -i {ssh_key}",
        source,
        f"{user}@{host}:{temp_dir}"
    ]
    
    try:
        # Run the rsync command
        subprocess.run(rsync_command, check=True)
        print(f"Files transferred to {temp_dir} on remote host {host}.")
        
        # Step 2: Move the files to the target directory using sudo with verbose output
        sudo_command = [
            "ssh", "-i", ssh_key,
            f"{user}@{host}",
            f"sudo mv -v {temp_dir}/* {target}/ && sudo rm -rf {temp_dir}"
        ]
        
        # Run the sudo move command
        subprocess.run(sudo_command, check=True)
        print(f"Files successfully moved to {target} with sudo.")
        
    except subprocess.CalledProcessError as e:
        print(f"Error during sync or sudo move: {e}")
        raise

if __name__ == "__main__":
    # Setup argument parser
    parser = argparse.ArgumentParser(description="Rsync files to a remote machine with sudo.")

    parser.add_argument("-u", "--user", required=True, help="Remote user")
    parser.add_argument("-k", "--ssh-key", required=True, help="Path to the SSH key")
    parser.add_argument("-s", "--source", required=True, help="Source directory")
    parser.add_argument("-t", "--target", required=True, help="Target directory on the remote machine (e.g., /opt)")
    parser.add_argument("-H", "--host", required=True, help="Remote host")
    parser.add_argument("--temp-dir", default="/tmp/rsync_temp", help="Temporary directory on the remote machine")

    # Parse arguments
    args = parser.parse_args()

    # Verify if SSH key exists
    if not os.path.isfile(args.ssh_key):
        raise FileNotFoundError(f"SSH key file not found: {args.ssh_key}")
    
    # Verify if source directory exists
    if not os.path.isdir(args.source):
        raise FileNotFoundError(f"Source directory not found: {args.source}")

    # Run the rsync function
    sync_files(args.user, args.ssh_key, args.source, args.temp_dir, args.target, args.host)
