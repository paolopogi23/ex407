#!/bin/bash

# Define variables
MOUNT_POINT="/mnt/temp"
TARGET_DIR="/opt/transfer"
FILE_PATTERN="system-deployment*.deb"

# Create the mount point if it doesn't exist
mkdir -p "$MOUNT_POINT"
mkdir -p "$TARGET_DIR"

# Function to mount, check file, and rsync
process_partition() {
    local partition=$1
    echo "Checking partition: $partition"
    
    # Try mounting the partition
    if mount "$partition" "$MOUNT_POINT"; then
        echo "Mounted $partition at $MOUNT_POINT"
        
        # Check if the target file exists using a wildcard
        if ls "$MOUNT_POINT/$FILE_PATTERN" 1> /dev/null 2>&1; then
            echo "File matching $FILE_PATTERN found on $partition"
            
            # Perform rsync
            rsync -av "$MOUNT_POINT/" "$TARGET_DIR/"
            echo "Files synced from $partition to $TARGET_DIR"

            # Unmount the partition and stop further processing
            umount "$MOUNT_POINT"
            echo "Unmounted $partition. Stopping further checks."
            return 0
        else
            echo "No file matching $FILE_PATTERN found on $partition"
        fi

        # Unmount the partition if no file is found
        umount "$MOUNT_POINT"
        echo "Unmounted $partition"
    else
        echo "Failed to mount $partition"
    fi

    # Return non-zero to indicate the file was not found
    return 1
}

# Check /dev/sda3 first, then only check /dev/sdb3 if the file wasn't found
if ! process_partition "/dev/sda3"; then
    process_partition "/dev/sdb3"
fi

# Clean up the mount point
rmdir "$MOUNT_POINT" 2>/dev/null
echo "Script finished"

==============================================


 late-commands:
    # Mount the installation media to access the software folder

    # Copy the script from the software folder to the target system
    - curtin in-target --target=/target -- cp /mnt/install-media/software/check_and_rsync.sh /opt/scripts/check_and_rsync.sh

    # Make the script executable
    - curtin in-target --target=/target -- chmod +x /opt/scripts/check_and_rsync.sh

    # Execute the script
    - curtin in-target --target=/target -- bash /opt/scripts/check_and_rsync.sh

    # Clean up: Unmount the installation media
    - curtin in-target --target=/target -- umount /mnt/install-media
