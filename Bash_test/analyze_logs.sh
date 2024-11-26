#!/bin/bash

# Файл логов
LOG_FILE="access.log"

# Подсчитать общее количество запросов
total_requests=$(wc -l < "$LOG_FILE")

# Подсчитать количество уникальных IP-адресов (с использованием awk)
unique_ips=$(awk '{print $1}' "$LOG_FILE" | sort | uniq | wc -l)

# Подсчитать количество запросов по методам (с использованием awk)
method_counts=$(awk '{print $6}' "$LOG_FILE" | tr -d '"' | sort | uniq -c | awk '{printf "%s %s\n", $1, $2}')

# Найти самый популярный URL (с использованием awk)
popular_url=$(awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -n 1 | awk '{printf "%s %s\n", $1, $2}')

# Создать отчет
cat <<EOL > report.txt
Отчет о логе веб-сервера
========================
Общее количество запросов: $total_requests
Количество уникальных IP-адресов: $unique_ips

Количество запросов по методам:
$method_counts

Самый популярный URL: $popular_url
EOL

echo "Отчет сохранен в файл report.txt"
