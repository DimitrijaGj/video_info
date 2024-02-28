#!/bin/bash

# List of direct video URLs (one per line)
URL_LIST="urls.txt"

# Output file for video information
OUTPUT_FILE="video_info.txt"

# Temporary directory for downloads
TEMP_DIR="temp_videos"
mkdir -p "$TEMP_DIR"

# Loop through each URL in the list
while IFS= read -r url; do
    echo "Processing $url..."

    # Extract filename from URL
    FILENAME=$(basename "$url")

    # Change to the temporary directory
    cd "$TEMP_DIR"

    # Use wget to download the video
    wget "$url" -O "$FILENAME"

    # Check if the download was successful
    if [ -f "$FILENAME" ]; then
        # Use ffprobe to get duration and format
        DURATION=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:n>
        FORMAT=$(ffprobe -v error -show_entries format=format_name -of default=noprint_wrappers=1:>

        # Write duration and format to the output file
        echo "URL: $url" >> "../$OUTPUT_FILE"
        echo "Duration: $DURATION" >> "../$OUTPUT_FILE"
        echo "Format: $FORMAT" >> "../$OUTPUT_FILE"
        echo "-------------------" >> "../$OUTPUT_FILE"

        # Delete the video file
        rm "$FILENAME"
    else
        echo "Failed to download $url" >> "../$OUTPUT_FILE"
    fi

    # Change back to the original directory
    cd -
done < "$URL_LIST"

echo "Processing complete. Check $OUTPUT_FILE for details."
