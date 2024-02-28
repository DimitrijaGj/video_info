#!/bin/bash

# Check if the number of seconds is passed as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 seconds"
    exit 1
fi

# Input total seconds (allowing floating-point numbers)
total_seconds=$1

# Calculate days, hours, minutes, and remaining seconds using bc for floating-point support
days=$(echo "$total_seconds / 86400" | bc)
hours=$(echo "($total_seconds % 86400) / 3600" | bc)
minutes=$(echo "($total_seconds % 3600) / 60" | bc)
seconds=$(echo "$total_seconds % 60" | bc)

# Since bc does not handle floating-point modulus directly for hours, minutes, and seconds calcula>
# we perform an additional step to calculate the floating-point part of seconds.
float_seconds=$(echo "scale=2; $total_seconds % 60" | bc)

# Output result
echo "$total_seconds seconds is equivalent to:"
echo "$days day(s), $hours hour(s), $minutes minute(s), and $seconds second(s)."
