#!/bin/bash

current_date=$(date +"%Y-%m-%d")
# Directory where videos are stored
VIDEO_DIR="/opt/robotframework/Results/$current_date"

# Filename prefix
NEW_NAME_PREFIX="video_$current_date"
COUNTER=1

for VIDEO_FILE in "$VIDEO_DIR"/*.webm; do
  EXTENSION="${VIDEO_FILE##*.}"
  # Create the new filename
  NEW_NAME="${VIDEO_DIR}/${COUNTER}_${NEW_NAME_PREFIX}.${EXTENSION}"
  # Rename the file
  mv "$VIDEO_FILE" "$NEW_NAME"
  # Increment the counter
  COUNTER=$((COUNTER + 1))
done

echo "Video renamed!"