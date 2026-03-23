#!/bin/bash
# Kamil Demel

trap 'echo -e "\nGoodbye!"; exit 0' SIGINT

sleep_time=3

if [ $# -eq 1 ]; then
    sleep_time="$1"
elif [ $# -gt 1 ]; then
    echo "Error: Invalid number of arguments."
    exit 1
fi

if [[ "$sleep_time" -lt 1 || "$sleep_time" -gt 10 ]]; then
    echo "Error: Argument out of range (must be between 1 and 10)."
    exit 1
fi

while true; do
    process_count=$(ps aux --no-headers | wc -l)
    echo "Current number of processes: $process_count"
    sleep "$sleep_time"
done
