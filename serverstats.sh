#!/bin/bash

# Update scripts
. ./update.sh

# Services to check (modify as needed)
services=(apache2 mysql redis ts3bot ts3server matrix-synapse)

# Get memory usage and free memory
mem_total=$(free -m | awk '/Mem:/{print $2}')
mem_free=$(free -m | awk '/Mem:/{print $3}')

# Get CPU usage (replace with preferred method)
cpu_load=$(top -b 1 -n 1 | grep "Cpu0" | awk '{print $3}')

# Check status of each service and format output
output=""
for service in "${services[@]}"; do
  status=$(systemctl is-active "$service")
  if [[ $status == "active" ]]; then
    output="$output$service:running\n"
  else
    output="$output$service:stopped\n"
  fi
done

# Append resource information
output="$output\nMem Total:$mem_total\nMem Free:$mem_free\nCPU Load:$cpu_load"

# Save output to cache file
echo -e "$output" > serverstat.txt