#!/bin/bash

# Check if the 'sips' command is available
if ! command -v sips &>/dev/null; then
  echo "The 'sips' command is not available. Please make sure you are on macOS."
  exit 1
fi

# Check if there are any HEIC files in the current directory
if ! ls *.HEIC &>/dev/null; then
  echo "No HEIC files found in the current directory."
  exit 1
fi

# Create a 'png' directory if it doesn't exist
mkdir -p png

# Convert HEIC files to PNG and store them in the 'png' directory
for file in *.HEIC; do
  base=$(basename "$file" .HEIC)
  sips -s format png "$file" --out "png/${base}.png"
done

echo "Conversion completed. PNG files are in the 'png' directory."

