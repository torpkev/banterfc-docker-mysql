#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Only starts this service in this compose project
docker compose -f docker-compose.mysql.yml -p banterfc-mysql up -d mysql

echo "✅ MySQL started (project: banterfc-mysql, service: mysql)"

