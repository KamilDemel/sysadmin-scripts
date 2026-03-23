#!/bin/bash
# Kamil Demel

trap 'echo -e "\nGoodbye!"; exit 0' SIGINT

if [ $# -eq 0 ]; then
    while true; do
        logged_in_users=$(who | awk '{print $1}' | sort -u)
        for user in $logged_in_users; do
            total_rss=$(ps -u "$user" -eo rss --no-headers | awk '{sum+=$1} END {print sum}')
            echo "$user ${total_rss:-0} KB"
        done
        sleep 3
    done
elif [ $# -gt 0 ]; then
    while true; do
        for target_user in "$@"; do
            if ! id "$target_user" &>/dev/null; then
                echo "Error: User '$target_user' does not exist."
                exit 1
            else
                total_rss=$(ps -u "$target_user" -eo rss --no-headers | awk '{sum+=$1} END {print sum}')
                echo "$target_user ${total_rss:-0} KB"
            fi
        done
        sleep 3
    done
fi
