#!/bin/bash
CPU=$(top -bn1 | awk -F',' '
/Cpu/ {
    for (i=1; i<=NF; i++) {
        if ($i ~ /id/) {
            gsub(/[^0-9.]/, "", $i)
            idle=$i
        }
    }
    printf "%.0f", 100 - idle
}')

MEM=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')

DISK=$(df / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')
# fallback if empty
CPU=${CPU:-0}
MEM=${MEM:-0}
DISK=${DISK:-0}

echo "CPU: ${CPU}%"
echo "Memory: ${MEM}%"
echo "Disk: ${DISK}%"

# convert safely to integers
CPU_INT=${CPU%.*}
MEM_INT=${MEM%.*}
DISK_INT=${DISK%.*}

if [ "$CPU_INT" -gt 80 ]; then
  echo "High CPU Usage!"
fi

if [ "$MEM_INT" -gt 80 ]; then
  echo "High Memory Usage!"
fi

if [ "$DISK_INT" -gt 20 ]; then
  echo "High Disk Usage!"
fi