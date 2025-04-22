#!/bin/bash

# ==========================================
#  Linux System Health Monitor
# ==========================================
# Descrition: Monitors CPU, RAM, and Disk usage. Sends alert if thresholds exceeded.
# Author: Darshan Lohade
# Usage: Can be added to cron for automation.

# Thresholds
MAX_CPU=80
MAX_MEM=85
MAX_DISK=90

# Log file path 
LOG_FILE="/var/log/health_monitor.log"

# Email settings 
SEND_EMAIL=false
EMAIL_TO="Oearn4837@gmail.com"
SUBJECT="System Health Alert on $(hostname)"

# Function to get usage stats
get_cpu_usage() {
	top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d'.' -f1
}

get_mem_usage() {
	free | grep Mem | awk '{printf("%.0f", $3/$2 * 100)}'
}

get_disk_usage() {
	df / | grep / | awk '{print $5}' | sed 's/%//g'
}

# Function to send email alert
send_alert() {
	local message=$1
	echo -e "$message" | mail -s "$SUBJECT" "$EMAIL_TO"
}

# Get current stats
cpu_usage=$(get_cpu_usage)
mem_usage=$(get_mem_usage)
disk_usage=$(get_disk_usage)
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Compose log
status="OK"
alert_message=""

if [ "$cpu_usage" -ge "$MAX_CPU" ]; then
    status="ALERT"
    alert_message+="CPU usage is high: $cpu_usage%\n"
fi

if [ "$mem_usage" -ge "$MAX_MEM" ]; then
    status="ALERT"
    alert_message+="Memory usage is high: $mem_usage%\n"
fi

if [ "$disk_usage" -ge "$MAX_DISK" ]; then
    status="ALERT"
    alert_message+="Disk usage is high: $disk_usage%\n"
fi

# Log entry
log_entry="[$timestamp] CPU: $cpu_usage% | MEM: $mem_usage% | DISK: $disk_usage% | STATUS: $status"
echo -e "$log_entry" >> "$LOG_FILE"

# Send alert if needed
if [ "$status" = "ALERT" ]; then
    echo -e "$log_entry\n\n$alert_message"
    if [ "$SEND_MAIL" = true ]; then
	send_alert "$log_entry\n\n$alert_message"
    fi
else
    echo "$log_entry"
fi

