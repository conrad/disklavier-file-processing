#!/bin/bash

directory="data/disklavier-fils"
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
    if [ "$dir_size" -lt "$dir_max_size" ]; then
        echo "just copy it over ($dir_size)"
        cp -r "$dir" "$output_dir"
    else
        num_files=$(find $dir -type f | wc -l)
        for (( i=0; i<=$num_files; i++ ))
        do
            for (( j=1; j<=10; j++ ))
            do
                mkdir -p "$output_dir-$i"
                echo .${dir[i]}
                # cp "$dir[$i]" "$output_dir-$i"
            done
        done

        # for ((i = 0; i < ${#dir[@]}; i += 10)); do
        #     echo "here $i"
        #     # Copy 10 files at a time
        #     # batch=("${files_to_copy[@]:i:10}")
        #     # echo $batch
        #     # cp -t "$output_dir" "${batch[@]}"
        # done
      fi
  fi
done
