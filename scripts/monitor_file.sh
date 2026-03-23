#!/bin/bash
# Kamil Demel

if [ $# -ne 1 ]; then
    echo "Error: Invalid number of arguments. Please provide a file."
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Error: Provided argument is not a regular file."
    exit 1
fi

last_size=$(stat -c %s "$1")
last_mod=$(stat -c %Y "$1")

while true; do
    if [ ! -f "$1" ]; then
        echo "Alert: File has been deleted."
        exit 0
    fi

    current_size=$(stat -c %s "$1")
    current_mod=$(stat -c %Y "$1")

    if [[ "$current_size" -ne "$last_size" || "$current_mod" -ne "$last_mod" ]]; then
        echo "Notice: File modification date or size has changed."
        last_size="$current_size"
        last_mod="$current_mod"
    fi
    
    sleep 4
done
