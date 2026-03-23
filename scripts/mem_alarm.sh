#!/bin/bash
# Kamil Demel

avail_mem=$(grep MemAvailable /proc/meminfo | awk '{print $2}')

if [ "$avail_mem" -lt 1000 ]; then
    echo "ALARM: Available memory is critically low (${avail_mem} KB)."
else
    echo "OK: Memory is sufficient (${avail_mem} KB)."
fi
