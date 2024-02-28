#!/bin/bash

# Define the input and output file names
input_file="video_info.txt"
output_file="format_lengths.txt"

# Check if input file exists
if [ ! -f "$input_file" ]; then
    echo "Input file does not exist."
    exit 1
fi

# Initialize an associative array to hold the total duration for each format
declare -A format_durations

# Read through the input file line by line
while IFS= read -r line; do
    # Check for duration line and extract duration
    if [[ $line =~ Duration:\ ([0-9]+\.[0-9]+) ]]; then
        duration=${BASH_REMATCH[1]}
    fi

    # Check for format line, extract format, and update total duration for each format found
    if [[ $line =~ Format:\ (.+) ]]; then
        # Split formats by commas and update their total durations
        IFS=',' read -ra formats <<< "${BASH_REMATCH[1]}"
        for format in "${formats[@]}"; do
            format_trimmed=$(echo "$format" | xargs) # Trim spaces
            format_durations["$format_trimmed"]=$(echo "${format_durations["$format_trimmed"]:-0} >
        done
    fi
done < "$input_file"

# Write the total lengths to the output file
rm -f "$output_file" # Remove the output file if it exists
for format in "${!format_durations[@]}"; do
    echo "$format: ${format_durations[$format]} seconds" >> "$output_file"
done

echo "The total lengths of each format have been written to $output_file."
