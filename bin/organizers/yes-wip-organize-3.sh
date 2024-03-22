#!/bin/bash

input_directory="data/disklavier-fils"
dir_max_size=7 # 7KB
IFS=$'\n' # Set Internal Field Separator to newline to handle spaces in directory names

current_time=$(date "+%Y.%m.%d-%H.%M.%S")
output_dir="output/organize-3/$current_time"

mkdir -p "$output_dir"

cp -r "$input_directory/." "$output_dir"

# Check if the target is not a directory
if [ ! -d "$input_directory" ]; then
  echo "The target is not a directory" >&2
  exit 1
fi

# What do we have to start with?
# var=$(ls $input_directory)
# echo "$var"

# Loop through files in the target directory
for dir in "$output_dir"/*; do
  if [ -f "$dir" ]; then
    echo "Uh oh, a file! $dir"
  fi

  if [ -d "$dir" ]; then
    du_output=$(du -k $dir)
    dir_size=$(echo "$du_output" | cut -f1)
    num_dirs_needed=$(($dir_size / $dir_max_size))

    echo "$dir"
    echo "size: $dir_size"
    echo "num_dirs_needed: $num_dirs_needed"

    for i in $(seq $num_dirs_needed)
    do
      mkdir -p "$dir-$i"

      du_output=$(du -k "$dir-$i")
      new_dir_size=$(echo "$du_output" | cut -f1)
      echo "$i new_dir_size: $new_dir_size"
      while [ $new_dir_size -lt $dir_max_size ]
      do
        echo "in while for $dir-$i"
        # TODO: Here is the issue. It's not finding the files here....
        for file in "$dir"/* ; do
          echo "$file"
          # echo mv -v -- "$file" "$dir-$i"
          # mv -v -- "$file" "$dir-$i"
          mv "$file" "$dir-$i"
          break
        done

        du_output=$(du -k "$dir-$i")
        echo $du_output
        new_dir_size=$(echo "$du_output" | cut -f1)
        echo "new_dir_size: $new_dir_size"
      done
    done
  fi
done
