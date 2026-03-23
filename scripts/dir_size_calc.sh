#!/bin/bash
# Kamil Demel

target_dir=""

if [ $# -eq 0 ]; then
    target_dir="."
else
    target_dir="$1"
    if [ ! -d "$target_dir" ]; then
        echo "Error: Provided parameter is not a directory."
        exit 1
    fi
fi

total_size=$(ls -l "$target_dir" | tail -n +2 | awk '{sum += $5} END {print sum}')

echo "Total size: $total_size bytes"
