#!/bin/bash

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
dirs=$(find disklavier-fils/ -type d)

run_dir="output/$current_time"
file_dir="output/$current_time/disklavier-fils"

mkdir -p "$run_dir"
mkdir -p "$file_dir"


# Function to calculate size of a directory in KB
calculate_directory_size() {
    du -sk "$1" | awk '{print $1}'
}

# Function to create subdirectories and move files
create_subdirectories() {
    # local source_dir="$1"
    # local max_size="$2"
    # local dest_dir="$3"
    local source_dir="disklavier-fils/"
    local max_size="713"
    local dest_dir="output/test"

    local current_size=0
    local subdir_index=1

    # Loop through files and directories
    while IFS= read -r entry; do
        local entry_size=$(calculate_directory_size "$entry")

        # Check if adding current entry exceeds max size
        if (( current_size + entry_size > max_size )); then
            (( subdir_index++ ))
            current_size=0
        fi

        # Create subdirectory if it doesn't exist
        local subdirectory="$dest_dir/subdir$subdir_index"
        mkdir -p "$subdirectory"

        # Move entry to subdirectory
        mv "$entry" "$subdirectory"

        # Update current size
        (( current_size += entry_size ))
    done < <(find "$source_dir" -maxdepth 1 ! -path "$source_dir" -print)
}

# input_directory="$1"
# max_size_kb="$2"
# output_directory="$3"
input_directory="disklavier-fils/"
max_size_kb="713"
output_directory="output/orig-organize/$current_time"

# # Check if input directory exists
# if [ ! -d "$input_directory" ]; then
#     echo "Error: Input directory $input_directory not found."
#     exit 1
# fi

# Check if output directory exists or create it
if [ ! -d "$output_directory" ]; then
    mkdir -p "$output_directory"
fi

# Check if max_size_in_kb is a valid number
if ! [[ "$max_size_kb" =~ ^[0-9]+$ ]]; then
    echo "Error: Maximum size must be a positive integer."
    exit 1
fi

# Call function to create subdirectories and move files
create_subdirectories "$input_directory" "$max_size_kb" "$output_directory"

echo "Files and directories organized into subdirectories of $max_size_kb KB or less in $output_directory."
