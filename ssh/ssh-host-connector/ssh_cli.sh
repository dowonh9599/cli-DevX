#!/bin/bash

entries=()
while IFS= read -r line; do
  entries+=("$line")
done < ssh_list.txt

# Calculate max lengths for each column
max_alias=0
max_username=0
max_hostname=0
max_port=2 # minimum length is 2 (default port "22")

for index in "${!entries[@]}"; do
  entry="${entries[$index]}"
  IFS='|' read -ra PARTS <<< "$entry"
  alias="${PARTS[0]}"
  IFS='@' read -ra SUBPARTS <<< "${PARTS[1]}"
  username="${SUBPARTS[0]}"
  IFS=' ' read -ra HOST_PARTS <<< "${SUBPARTS[1]}"
  hostname="${HOST_PARTS[0]}"
  port="${HOST_PARTS[2]}"
  if [ -z "$port" ]; then
    port=22
  fi

  if [ ${#alias} -gt $max_alias ]; then
    max_alias=${#alias}
  fi
  if [ ${#username} -gt $max_username ]; then
    max_username=${#username}
  fi
  if [ ${#hostname} -gt $max_hostname ]; then
    max_hostname=${#hostname}
  fi
  if [ ${#port} -gt $max_port ]; then
    max_port=${#port}
  fi
done

# Print table header
printf "%-5s | %-${max_alias}s | %-${max_username}s | %-${max_hostname}s | %-${max_port}s\n" "Index" "Alias" "Username" "Hostname" "Port"
printf "%$((5+max_alias+max_username+max_hostname+max_port+12))s\n" | tr ' ' '-'

# Print table rows
for index in "${!entries[@]}"; do
  entry="${entries[$index]}"
  IFS='|' read -ra PARTS <<< "$entry"
  alias="${PARTS[0]}"
  IFS='@' read -ra SUBPARTS <<< "${PARTS[1]}"
  username="${SUBPARTS[0]}"
  IFS=' ' read -ra HOST_PARTS <<< "${SUBPARTS[1]}"
  hostname="${HOST_PARTS[0]}"
  port="${HOST_PARTS[2]}"
  if [ -z "$port" ]; then
    port=22
  fi
  printf "%-5s | %-${max_alias}s | %-${max_username}s | %-${max_hostname}s | %-${max_port}s\n" "$index" "$alias" "$username" "$hostname" "$port"
done

read -p "Enter the index number to connect: " index

if [[ "$index" -ge 0 && "$index" -lt ${#entries[@]} ]]; then
  entry="${entries[$index]}"
  IFS='|' read -ra PARTS <<< "$entry"
  user_host="${PARTS[1]}"

  ssh $user_host
else
  echo "Invalid index number!"
fi
