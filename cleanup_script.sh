#!/bin/bash

# Set the directory paths to the .next cache and additional cache directory
NEXT_CACHE_DIR="/root/modjen-frontend/.next/cache"
ADDITIONAL_CACHE_DIR="/usr/local/share/.cache/"

# Define the number of days after which cached images should be deleted
DAYS_THRESHOLD=10

# Function to delete files and directory if it exists
delete_files_and_dir_if_exist() {
    local dir=$1
    if [ -d "$dir" ]; then
        rm -rf "$dir"
        echo "Deleted directory $dir"
    else
        echo "Directory $dir does not exist. Skipping cleanup."
    fi
}

# Delete files and directory from .next cache directory if it exists
delete_files_and_dir_if_exist "$NEXT_CACHE_DIR"

# Delete files and directory from additional cache directory if it exists
delete_files_and_dir_if_exist "$ADDITIONAL_CACHE_DIR"
