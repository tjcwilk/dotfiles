#!/bin/bash

# Define the target file and search string
FILE="/home/toby/.bashrc"
SEARCH_STRING="# My custom bashrc settings"

# Check if the file exists
if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' not found!"
    exit 1
fi

# Use awk to retain lines up to (and including) the SEARCH_STRING
awk -v pattern="$SEARCH_STRING" '
    $0 ~ pattern {print; exit} # Print the matched line and exit
    {print}                   # Print all lines before the matched line
' "$FILE" > tmp_file && mv tmp_file "$FILE"

echo "All lines after '$SEARCH_STRING' have been deleted in '$FILE'."
