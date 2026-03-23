#!/bin/bash
# Kamil Demel

if [ $# -eq 0 ]; then
    echo "Error: Please provide at least one username as an argument."
    exit 1
fi

for target_user in "$@"; do
    if ! id "$target_user" &>/dev/null; then
        echo "Error: User '$target_user' does not exist."
        continue
    else
        total_rss=$(ps -u "$target_user" -eo rss --no-headers | awk '{sum+=$1} END {print sum}')
        echo "$target_user ${total_rss:-0} KB"
    fi
done
