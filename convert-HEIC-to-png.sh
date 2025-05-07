#!/bin/bash

# Check if the 'sips' command is available
if ! command -v sips &>/dev/null; then
  echo "The 'sips' command is not available. Please make sure you are on macOS."
  exit 1
fi

# Enable nullglob so unmatched globs are removed
shopt -s nullglob

# Collect files
files=( *.HEIC *.JPG *.jpg )

# Check if there are any files
if [ ${#files[@]} -eq 0 ]; then
  echo "No HEIC or JPG files found in the current directory."
  exit 1
fi

# Create a 'png' directory if it doesn't exist
mkdir -p png

# Convert files to PNG
for file in "${files[@]}"; do
  base="${file%.*}"
  sips -s format png "$file" --out "png/${base}.png"
done

echo "Conversion completed. PNG files are in the 'png' directory."
