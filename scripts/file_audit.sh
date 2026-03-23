#!/bin/bash
# Kamil Demel

target_dir=""

if [ $# -gt 1 ]; then
    echo "Error: Invalid number of arguments."
    exit 1
fi

if [ $# -eq 0 ]; then
    target_dir="."
elif [ $# -eq 1 ]; then
    target_dir="$1"
fi

if [ ! -d "$target_dir" ]; then
    echo "Error: The provided argument is not a directory."
    exit 1
fi

cd "$target_dir" || exit 1

for file in *; do
    file_size=$(stat -c %s "$file")
    owner_name=$(stat -c %U "$file")
    
    if [ -x "$file" ] && [ -f "$file" ]; then
        echo "$file $owner_name $file_size EXEC"
    elif [ -f "$file" ]; then
        echo "$file $owner_name $file_size NOEXEC"
    fi
done
