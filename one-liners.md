# Linux One-Liners & CLI Utilities

A comprehensive collection of shell commands utilizing `awk`, `sed`, `grep`, `find`, and process management tools for daily system administration tasks.

## 👤 User & Group Management
| Command | Description |
|---------|-------------|
| `awk -F: '{print $1, length($1)}' /etc/passwd` | Print all usernames along with their character length. |
| `awk -F: 'length($1) == 8 {print $1}' /etc/passwd` | Find all usernames that are exactly 8 characters long. |
| `grep "/bin/bash" /etc/passwd \| head -n 3 \| cut -d: -f 1` | Get the first 3 users who have `/bin/bash` set as their default shell. |
| `cat /etc/passwd \| cut -d: -f 7 \| sort \| uniq` | List all unique login shells currently used in the system. |
| `awk -F: ' $3 >= 0 && $3 <= 999 \|\| $3 == 1001 {print $4,$1}' /etc/passwd` | Print GID and username for users with UIDs between 0-999 or exactly 1001. |
| `awk -F: ' $5 ~ /Kowalski/ {count+=1} END {print count+0}' /etc/passwd` | Count users with the name "Kowalski" in the GECOS info field. |
| `cat /etc/passwd \| awk -F: '{print $4}' \| sort -n \| uniq -c \| awk '$1 == 1 {count++} END {print count}'` | Count unique GIDs that have exactly one user assigned to them. |
| `awk -F: '{print $4}' /etc/passwd \| sort -n \| uniq \| wc -l` | Count the total number of unique GIDs actively used in `/etc/passwd`. |
| `awk -F: '{print $4}' /etc/passwd \| sort -n \| uniq -c \| sort -nr -k 1 \| head -n 1 \| awk '{print $2}'` | Find the most frequently used GID in the system. |
| `awk -F: '{print $3}' /etc/passwd \| sort -n -r 2>/dev/null \| head -n 1` | Find the highest assigned UID in the system. |
| `cat /etc/group \| wc -l` | Count the total number of user groups. |
| `awk -F: '$4 == "" {count+=1} END {print count+0}' /etc/group` | Count groups that currently have no assigned users. |
| `who \| grep "^r"` | List currently logged-in users whose username starts with "r". |
| `who \| awk '{FS=" "} substr($5, 2, 2) == "10" {print $1}' \| grep -E "^s[0-9]{6}"` | Extract specific student accounts (regex `s+6 digits`) based on connection IP/display matching. |

## 📁 File & Directory Operations
| Command | Description |
|---------|-------------|
| `find ~/project -type f -name "*.sh" -exec chmod 754 {} +` | Set `rwxr-xr--` permissions efficiently for all shell scripts in a directory. |
| `chmod 4755 ~/test.txt` | Set the SUID bit and `rwxr-xr-x` permissions on a specific file. |
| `umask 0177` | Set the default file creation mask to `rw-------`. |
| `cp source/* dest 2> /dev/null` | Copy all files from source to destination, suppressing any error messages. |
| `find ~ -type f \| wc -l` | Count the total number of files within the home directory. |
| `find /usr/include -maxdepth 2 -type f \| wc -l` | Count files up to 2 directory levels deep. |
| `find /usr/include -mindepth 1 -maxdepth 1 -type d \| wc -l` | Count the immediate subdirectories of a given path. |
| `find /usr/include -type d -name "s??????" \| wc -l` | Count directories with exactly 7-letter names starting with "s". |
| `find /usr/include -mindepth 1 -maxdepth 1 -type f -name "m???.h" \| wc -l` | Count `.h` files with exactly 5-character names starting with "m". |
| `find /usr/include -type f \| grep "\.h$" \| grep "td" \| wc -l` | Count `.h` files that contain "td" anywhere in their path. |
| `find /etc -type f -exec wc -l {} + 2>/dev/null` | Summarize the line counts of all files inside `/etc`. |
| `find /usr/include -mindepth 1 -type f -size +12000c \| wc -l` | Count files strictly larger than 12,000 bytes. |
| `find /usr/include -mindepth 1 -maxdepth 1 -type f -name "m*.h" ! -size +12k \| wc -l` | Find `.h` files starting with "m" that are NOT larger than 12KB. |
| `find $HOME -type f -printf "%s %p\n" \| sort -nr -k 1 \| head -n 1 \| awk '{print $1}'` | Get the byte size of the single largest file in the home directory. |
| `ls -1tr ~ \| head -n 1` | Find the oldest file or directory in the home directory. |
| `stat /tmp -c %i` | Display the inode number of the `/tmp` directory. |
| `ls -id /tmp \| awk '{print $1}'` | Alternative method to get the inode number of a directory. |

## ⚙️ Process & System Monitoring
| Command | Description |
|---------|-------------|
| `ps aux --no-headers \| cut -d " " -f 1 \| sort \| uniq -c \| sort -n -r \| head -n 1` | Find the username running the highest number of processes. |
| `ps --no-headers -e -o user \| sort -k 1 \| uniq -c \| sort -n -r \| head -n 1 \| awk '{print $2}'` | Alternative, faster method to find the user with the most active processes. |
| `ps -e -o user,stat,tty,rss --sort -rss \| awk '$2 ~ /^S/ && $3 == "?" { print $1; exit }'` | Find the user of the sleeping, background process consuming the most memory. |
| `ps --no-headers -e -o pid,vsz \| sort -nr -k 2 \| head -n 1 \| awk '{print $1}'` | Identify the PID of the process consuming the most virtual memory (VSZ). |
| `ps -eo pid,pmem --no-headers \| awk '$2!=0.0 {print $1,$2}'` | List PIDs and memory usage for processes actively consuming RAM. |
| `ps --no-headers -e -o pid,command,time --sort -time \| head -n 1` | Find the process that has consumed the most total CPU time. |
| `ps --no-headers -e -o stat \| grep "^S" \| wc -l` | Count the total number of processes currently in the Sleeping (S) state. |
| `ps --no-headers -e -o tty \| grep -v "^?" \| wc -l` | Count the number of processes actively attached to a terminal. |
| `ps --no-headers -e -o ppid \| awk '$1 == 1 {count+=1} END {print count+0}'` | Count processes directly orphaned/adopted by `init`/`systemd` (PID 1). |
| `ps --ppid 1 --no-headers \| wc -l` | Shorter method to count children of PID 1. |
| `ps --ppid $$ --no-headers \| wc -l` | Count the child processes of the current shell session. |
| `ps --no-headers -e -o nice \| awk '$1 > 0 {print $1}' \| wc -l` | Count processes running with a lowered priority (positive nice value). |
| `ps --no-headers -e -o nice \| awk '$1 < 0 {count+=1} END {print count+0}'` | Count processes running with elevated priority (negative nice value). |
| `kill -SIGUSR1 1000` | Send the custom `SIGUSR1` signal to the process with PID 1000. |

## 📝 Text Processing & Environment
| Command | Description |
|---------|-------------|
| `grep -v "^#" /etc/protocols \| awk '{print $1}' \| sort -r` | List all network protocol names, ignoring comments, sorted in reverse. |
| `grep -v "^\[" /etc/opt/remi/php80/php.ini \| grep -v -c "^$"` | Count actual configuration lines in `php.ini` (excluding empty lines and section headers). |
| `grep -E "[a-zA-Z0-9._+]+@[a-z.]+"` | Filter standard input for patterns matching email addresses. |
| `echo $PATH` | Display the current directories in the execution PATH. |
| `export PATH=$PATH:.` | Append the current working directory to the system PATH. |



