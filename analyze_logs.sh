#!/usr/bin/env bash

LOG_FILE="access.log"

if [ ! -f "$LOG_FILE" ] || [ $(wc -l < "$LOG_FILE") -lt 300 ]; then
    echo "Генерация тестового файла $LOG_FILE..."
    > "$LOG_FILE"
    
    IPS=("192.168.1.10" "10.0.0.5" "172.16.0.2" "192.168.1.50" "8.8.8.8")
    METHODS=("GET" "POST" "PUT" "DELETE")
    ENDPOINTS=("/api/users" "/api/login" "/api/data" "/api/status")
    CODES=("200" "200" "200" "401" "404" "500" "502")

    for i in {1..350}; do
        IP=${IPS[$RANDOM % ${#IPS[@]}]}
        METHOD=${METHODS[$RANDOM % ${#METHODS[@]}]}
        ENDPOINT=${ENDPOINTS[$RANDOM % ${#ENDPOINTS[@]}]}
        CODE=${CODES[$RANDOM % ${#CODES[@]}]}
        echo "$IP [15/Aug/2026:10:15:32] \"$METHOD $ENDPOINT HTTP/1.1\" $CODE" >> "$LOG_FILE"
    done
fi

echo "=== Результаты анализа логов ==="
TOTAL_REQUESTS=$(wc -l < "$LOG_FILE")
echo "Общее количество запросов: $TOTAL_REQUESTS"

echo "Топ-3 IP-адреса:"
grep -E -o "([0-9]{1,3}\.){3}[0-9]{1,3}" "$LOG_FILE" | awk '{print $1}' | sort | uniq -c | sort -nr | head -n 3

ERRORS_COUNT=$(awk '$9 ~ /^[45][0-9]{2}$/ {count++} END {print count+0}' "$LOG_FILE")
echo "Количество запросов с кодами 4xx и 5xx: $ERRORS_COUNT"

