# Infra Monitoring Project

Проект автоматизации мониторинга доступности API, анализа серверных логов и контейнеризации сервисов.

## Структура проекта

* check_api.sh — Bash-скрипт для проверки доступности API по HTTP-коду ответа.
* analyze_logs.sh — Bash-скрипт для генерации тестового access.log и анализа статистики запросов.
* docker-compose.yml — конфигурация стека из echo-сервера (hashicorp/http-echo) и обратного прокси (nginx:alpine).
* nginx.conf — правила проксирования входящих запросов с порта 80 на внутренний порт 8080 сервиса api.
* .github/workflows/ci.yml — пайплайн автоматической проверки синтаксиса и тестирования скриптов при создании Pull Request.

## Инструкции по запуску

### 1. Запуск Bash-скриптов мониторинга и анализа
Запустите:
```bash
chmod +x check_api.sh analyze_logs.sh
./check_api.sh https://httpbin.org/status/200
./check_api.sh https://httpbin.org/status/404
./analyze_logs.sh
