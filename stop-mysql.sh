#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Stops just this service; volumes remain intact
docker compose -f docker-compose.mysql.yml -p banterfc-mysql stop mysql

echo "🛑 MySQL stopped (project: banterfc-mysql, service: mysql)"

