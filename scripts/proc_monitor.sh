#!/bin/bash
# Kamil Demel

for ((i=1; i<=5; i++)); do
    process_count=$(ps aux --no-headers | wc -l)
    echo "Iteration $i/5: $process_count active processes."
    sleep 3
done

echo "Monitoring completed."
