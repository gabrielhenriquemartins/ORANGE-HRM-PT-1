#!/bin/bash

current_date=$(date +"%Y-%m-%d")
folder_path="/opt/robotframework/Results/$current_date"

# Check if the folder exists
if [ -d "$folder_path" ]; then
    # If the folder exists, delete it
    echo "Deleting existing folder: $folder_path"
    rm -rf "$folder_path"
fi

# Create a new folder
echo "Creating new folder: $folder_path"
mkdir -p "$folder_path"