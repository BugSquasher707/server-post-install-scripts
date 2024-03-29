#!/bin/bash

# Set the threshold for disk usage (80% in this case)
THRESHOLD=80

# Specify the path of the script you want to run when the threshold is reached
SCRIPT_TO_RUN="/root/cleanup_scheduler.sh"

# Define the log file path
LOG_FILE="/root/disk_usage_cleanup.log"

# Get current date and time for logging
current_time=$(date "+%Y-%m-%d %H:%M:%S")

# Check the disk usage of the root filesystem ('/' can be changed to another mount point if needed)
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# Check if the disk usage is greater than or equal to the threshold
if [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then
    echo "[$current_time] Disk usage is above $THRESHOLD% at ${DISK_USAGE}%. Running the script..." | tee -a "$LOG_FILE"
    bash "$SCRIPT_TO_RUN"
else
    echo "[$current_time] Disk usage is below $THRESHOLD% at ${DISK_USAGE}%. No action taken." | tee -a "$LOG_FILE"
fi
