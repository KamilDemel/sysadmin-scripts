#!/bin/bash
# Kamil Demel

if [ $# -ne 2 ] && [ $# -ne 3 ]; then
    echo "Error: Invalid number of arguments."
    exit 1
fi

target_file="$1"
if [ ! -f "$target_file" ]; then
    echo "Error: The first argument must be a regular file."
    exit 2
fi

target_dir="$2"
if [ ! -d "$target_dir" ]; then
    echo "Error: The second argument must be a directory."
    exit 2
fi

subdirs_count="$3"
if [ -z "$subdirs_count" ]; then
    read -p "Missing 3rd argument. Please enter the number of directories to create: " subdirs_count
fi

if [ "$subdirs_count" -gt 5 ]; then
    echo "Error: Number of subdirectories exceeds the limit (max 5)."
    exit 2
fi

cd "$target_dir" || exit 2

for ((i=1; i<=subdirs_count; i++)); do
    subdir="dir_$i"
    if [ -d "$subdir" ]; then
        echo "Notice: Directory $subdir already exists."
    else
        if ! mkdir "$subdir" 2>/dev/null; then
            echo "Error: Failed to create directory $subdir." >&2
            exit 2
        fi
    fi
    
    if ! cp "../$target_file" "$subdir" 2>/dev/null; then
        echo "Error: Failed to copy the file to $subdir." >&2
        exit 3
    fi
done
