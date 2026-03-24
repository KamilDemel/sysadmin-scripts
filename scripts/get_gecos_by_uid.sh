#!/bin/bash
# Kamil Demel

if [ $# -eq 0 ]; then
    read -p "Please enter a UID: " input_uid
    uid_list="$input_uid"
else
    uid_list="$@"
fi

for target_uid in $uid_list; do
    gecos_comment=$(awk -F: -v search_uid="$target_uid" '$3==search_uid {print $5}' /etc/passwd)
    
    if [ -n "$gecos_comment" ]; then
        echo "UID: $target_uid | GECOS: $gecos_comment"
    else
        echo "UID: $target_uid | Warning: User not found or GECOS field is empty."
    fi
done
