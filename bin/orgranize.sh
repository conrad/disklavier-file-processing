#!/bin/bash

directory="disklavier-fils"
dir_max_size=713
IFS=$'\n' # Set Internal Field Separator to newline to handle spaces in directory names

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
output_dir="output/organize/$current_time"

mkdir -p "$output_dir"

# Check if the target is not a directory
if [ ! -d "$directory" ]; then
  echo "The target is not a directory" >&2
  exit 1
fi

# Loop through files in the target directory
for dir in "$directory"/*; do
  if [ -f "$dir" ]; then
    echo "Uh oh, a file! $dir"
  fi

  if [ -d "$dir" ]; then
    du_output=$(du -k $dir)
    dir_size=$(echo "$du_output" | cut -f1)
    echo "$dir_size"
    if [ "$dir_size" -lt "$dir_max_size" ]; then
        echo "just copy it over ($dir_size)"
        cp -r "$dir" "$output_dir"
    else
        echo "Do something else: $dir"
    fi
  fi
done
