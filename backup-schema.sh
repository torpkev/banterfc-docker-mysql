# backup-schema.sh  (MySQL schema-only dump via Docker Compose)
#!/usr/bin/env bash
set -euo pipefail

# ---- Config (override via env or inline exports) ----
COMPOSE_FILE="${COMPOSE_FILE:-docker-compose.mysql.yml}"   # e.g. docker-compose.mysql.yml
PROJECT="${PROJECT:-banterfc-mysql}"                        # docker compose -p <project>
SERVICE="${SERVICE:-mysql}"                                 # service name inside the compose file
ENV_FILE="${ENV_FILE:-.env.compose}"                        # falls back to .env if missing
PROFILE="${PROFILE:-}"                                      # optional; leave empty if not used

# ---- Output path/naming ----
STAMP="$(date +%F_%H%M%S)"
OUTDIR="${OUTDIR:-backups/schema}"
OUTFILE="${OUTFILE:-${OUTDIR}/banterfc_schema_${STAMP}.sql.gz}"
mkdir -p "${OUTDIR}"

# ---- Env file detection ----
if [[ -f "${ENV_FILE}" ]]; then
  ENV_FLAG=(--env-file "${ENV_FILE}")
elif [[ -f ".env" ]]; then
  ENV_FLAG=(--env-file ".env")
else
  ENV_FLAG=()
fi

# ---- Base docker compose cmd ----
dc=(docker compose -f "${COMPOSE_FILE}" -p "${PROJECT}" "${ENV_FLAG[@]}")

# ---- Preflight checks ----
if [[ ! -f "${COMPOSE_FILE}" ]]; then
  echo "ERROR: Compose file '${COMPOSE_FILE}' not found."
  exit 1
fi

if ! "${dc[@]}" config --services | grep -qx "${SERVICE}"; then
  echo "ERROR: Service '${SERVICE}' not found in compose file."
  exit 1
fi

profile_flag=()
if [[ -n "${PROFILE}" ]]; then
  profile_flag=(--profile "${PROFILE}")
fi

if ! "${dc[@]}" ps --services --filter "status=running" | grep -qx "${SERVICE}"; then
  echo "INFO: '${SERVICE}' not running — starting..."
  "${dc[@]}" up -d "${SERVICE}" "${profile_flag[@]}"
  sleep 2
fi

echo "==> Dumping schema (no data) to ${OUTFILE}"

"${dc[@]}" "${profile_flag[@]}" exec -T "${SERVICE}" sh -s <<'IN_CONTAINER' | gzip -9 > "${OUTFILE}"
set -euo pipefail
: "${MYSQL_ROOT_PASSWORD:?MYSQL_ROOT_PASSWORD is not set in container env}"
DB_NAME="${MYSQL_DATABASE:-banterfc}"

mysqldump \
  -uroot -p"$MYSQL_ROOT_PASSWORD" \
  --databases "$DB_NAME" \
  --no-data \
  --routines --events --triggers \
  --default-character-set=utf8mb4 \
  --set-gtid-purged=OFF \
  --column-statistics=0 \
  --no-tablespaces
IN_CONTAINER

echo "==> Done: ${OUTFILE}"

