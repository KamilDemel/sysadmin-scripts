#!/bin/bash
# Kamil Demel

target_user="$1"

if ! stat /etc/passwd &>/dev/null; then
    echo "Error: The file /etc/passwd does not exist or is inaccessible."
    exit 1
fi

if [ $# -eq 0 ]; then
    read -p "Please provide a username: " target_user
fi

if [ -z "$target_user" ] || [[ "$target_user" =~ [^[:alnum:]] ]]; then
    echo "Error: Invalid username format. Only alphanumeric characters are allowed."
    exit 1
fi

gecos_comment=$(grep "^$target_user:" /etc/passwd | awk -F: '{print $5}')

if [ -z "$gecos_comment" ]; then
    echo "Warning: No GECOS (comment) found for user '$target_user'."
else
    echo "User: $target_user | GECOS: $gecos_comment"
fi
