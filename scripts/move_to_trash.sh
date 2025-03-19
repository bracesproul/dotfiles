#!/bin/bash

# Check if the argument is provided
if [ $# -eq 0 ]; then
    echo "Please provide a directory name as an argument."
    exit 1
fi

# Get the directory name from the argument
directory="$1"

# Check if the provided argument is a directory
if [ ! -d "$directory" ]; then
    echo "The provided argument is not a directory."
    exit 1
fi

# Create the Trash directory if it doesn't exist
trash_dir="/Users/bracesproul/.aliased_trash"

# Move the directory to the Trash directory
mv "$directory" "$trash_dir"

echo "Directory '$directory' has been moved to '$trash_dir'."