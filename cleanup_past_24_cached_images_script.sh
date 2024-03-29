#!/bin/bash

# Define log file path
LOG_FILE="/root/cleanup_past_24_cached_images_script.log"

# Set the directory paths
IMAGES_DIR="/root/modjen-frontend/.next/cache/images"

# Define the number of days after which cached images should be deleted
DAYS_THRESHOLD=1

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Function to delete files and directory if it exists
delete_files_and_dir_if_exist() {
    local dir=$1
    if [ -d "$dir" ]; then
        rm -rf "$dir"
        log_message "Deleted directory $dir"
    else
        log_message "Directory $dir does not exist. Skipping cleanup."
    fi
}

# Function to delete files created in the past 24 hours within a specified directory
delete_files_created_in_last_24h() {
    local dir=$1
    find "$dir" -type f -mtime -1 -exec rm {} \;
    log_message "Deleted files created in the last 24 hours in directory $dir"
}

# Starting the cleanup process
log_message "Starting the cleanup process."

# Delete files within the images directory that were created in the past 24 hours
delete_files_created_in_last_24h "$IMAGES_DIR"

log_message "Cleanup process completed."
