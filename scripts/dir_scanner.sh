#!/bin/bash
# Kamil Demel

target_dir="$1"

if [ $# -gt 1 ]; then
    echo "Error: Invalid number of arguments."
    exit 1
fi

if [ $# -eq 0 ]; then
    cd "." || exit 1
else
    cd "$target_dir" || exit 1
fi

for file in *; do
    [ -e "$file" ] || continue
    
    if [ ! -f "$file" ]; then
        continue
    else
        file_info=$(stat -c "%n %s" "$file")
        if [ -x "$file" ]; then
            echo "$file_info EXECUTE"
        else
            echo "$file_info"
        fi
    fi
done
