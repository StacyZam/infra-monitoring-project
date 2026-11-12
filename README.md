# Infra Monitoring Project

Проект автоматизации мониторинга доступности API, анализа серверных логов и контейнеризации сервисов.

## Инструкции по запуску

### 1. Запуск Bash-скриптов мониторинга и анализа
Запустите:
```bash
chmod +x check_api.sh analyze_logs.sh
./check_api.sh https://httpbin.org/status/200
./check_api.sh https://httpbin.org/status/404
./analyze_logs.sh
