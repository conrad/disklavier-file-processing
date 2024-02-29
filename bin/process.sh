#!/bin/bash

# Run from outside the scripts directory
dir_max_size=713
sizelimitMB=${1:-1000} # in MB
IFS=$'\n' # Set Internal Field Separator to newline to handle spaces in directory names

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
dirs=$(find disklavier-fils/ -type d)

run_dir="output/process/$current_time"
file_dir="output/process/$current_time/disklavier-fils"

mkdir -p "$run_dir"
mkdir -p "$file_dir"

for dir in $dirs; do
    echo "here $dir"
    if [ "$dir" != "disklavier-fils/" ]; then
        echo "Directory: $dir"
        du_output=$(du -k $dir)
        dir_size=$(echo "$du_output" | cut -f1)
        # if [ "$dir_size" -lt "$dir_max_size" ]; then
        #   echo "$dir_size... split it up!"
        #   sizesofar=0
        #   dircount=1
        #   du -s -B "1M" "$dir"/* | while read -r size file
        #   do
        #     if ((sizesofar + size > sizelimit))
        #     then
        #       (( dircount++ ))
        #       sizesofar=0
        #     fi
        #     (( sizesofar += size ))
        #     mkdir -p "$dir/sub_$dircount"
        #     mv "$file" "$dir/sub_$dircount"
        #   done
        # else
          echo "just copy it over ($dir_size)"
          cp -r "$dir" "$run_dir/$dir"
        # fi
    fi
done
