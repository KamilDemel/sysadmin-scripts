# Functional Bash Scripts

This directory contains standalone, parameterized shell scripts written for automation, resource monitoring, and file system management.

| Script File | Functionality | Key Concepts Demonstrated |
|-------------|---------------|---------------------------|
| `monitor_file.sh` | Continuously monitors a specified regular file for changes in size or modification date (`stat`) and alerts the user. | Infinite loops, `stat` parsing. |
| `dir_size_calc.sh` | Calculates and returns the total byte size of all files within a specified or current directory. | Input validation, `awk` summation. |
| `process_counter.sh` | Periodically counts and prints the total number of running processes at an interval (1-10s) provided as an argument. | `trap` signal handling (SIGINT). |
| `exec_finder.sh` | Iterates through a given directory, lists regular files, and explicitly flags those with execution permissions. | `for` loops, test operators (`-x`, `-f`). |
| `file_audit.sh` | Scans a directory and prints a formatted report containing file name, owner, size, and execution status. | String formatting, variable assignment. |
| `mem_usage_users.sh` | Calculates and displays total memory usage (RSS in KB) either for all currently logged-in users or specific users passed as arguments. | `who`, user validation (`id`). |
| `backup_generator.sh` | Takes a file and a directory, then creates multiple numbered subdirectories (max 5) and copies the file into each of them. | `for` loops, error redirection (`2>/dev/null`). |
| `dir_scanner.sh` | Lists files in a given directory alongside their sizes, explicitly marking executable files. | Conditionals, directory traversal. |
| `user_rss_calc.sh` | Takes multiple usernames as arguments, validates their existence, and calculates their total RAM (RSS) footprint. | Parameter expansion (`$@`), process parsing. |
| `mem_alarm.sh` | Checks available system memory via `/proc/meminfo` and triggers an alarm if it drops below a critical threshold. | `/proc` filesystem parsing, numeric comparison. |
| `get_gecos.sh` | Retrieves the GECOS (comment) field from `/etc/passwd` for a specified username, prompting for input if no argument is given. | Regex matching, file parsing. |
| `proc_monitor.sh` | Simple monitoring tool that logs the total number of active processes 5 times with a 3-second interval. | Defined iterations (`for`), process counting. |
| `get_gecos_by_uid.sh` | Fetches the GECOS field from `/etc/passwd` based on specific UIDs provided via arguments or interactive prompt. | `awk` variable passing (`-v`). |

## Usage
Each script requires execution permissions before running:
```bash
chmod +x <script_name>.sh
./<script_name>.sh [arguments]
