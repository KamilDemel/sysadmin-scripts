#!/bin/bash
# Kamil Demel

target_dir=""

if [ $# -gt 1 ]; then
    echo "Error: Invalid number of arguments."
    exit 1
fi

if [ $# -eq 0 ]; then
    target_dir="."
else
    target_dir="$1"
fi

if [ ! -d "$target_dir" ]; then
    echo "Error: Directory does not exist or cannot be read."
    exit 1
fi

cd "$target_dir" || exit 1

for file in *; do
    if [ -x "$file" ] && [ -f "$file" ]; then
        echo "$file EXECUTE"
    elif [ -f "$file" ]; then
        echo "$file"
    fi
done
