# backup-full.sh  (MySQL full dump via Docker Compose)
#!/usr/bin/env bash
set -euo pipefail

# ---- Config (override via env or inline exports) ----
COMPOSE_FILE="${COMPOSE_FILE:-docker-compose.mysql.yml}"   # e.g. docker-compose.mysql.yml
PROJECT="${PROJECT:-banterfc-mysql}"                        # docker compose -p <project>
SERVICE="${SERVICE:-mysql}"                                 # service name inside the compose file
ENV_FILE="${ENV_FILE:-.env.compose}"                        # falls back to .env if missing
PROFILE="${PROFILE:-}"                                      # optional; leave empty if you don't use profiles

# ---- Output path/naming ----
STAMP="$(date +%F_%H%M%S)"
OUTDIR="${OUTDIR:-backups/full}"
OUTFILE="${OUTFILE:-${OUTDIR}/banterfc_full_${STAMP}.sql.gz}"
mkdir -p "${OUTDIR}"

# ---- Find an env file to use (compose env, then .env, else none) ----
if [[ -f "${ENV_FILE}" ]]; then
  ENV_FLAG=(--env-file "${ENV_FILE}")
elif [[ -f ".env" ]]; then
  ENV_FLAG=(--env-file ".env")
else
  ENV_FLAG=()  # fine — compose can still run without an env file
fi

# ---- Build base docker compose command ----
dc=(docker compose -f "${COMPOSE_FILE}" -p "${PROJECT}" "${ENV_FLAG[@]}")

# ---- Helpful preflight checks ----
if [[ ! -f "${COMPOSE_FILE}" ]]; then
  echo "ERROR: Compose file '${COMPOSE_FILE}' not found in $(pwd)."
  echo "Hint: set COMPOSE_FILE=compose.yaml (or correct file name) before running."
  exit 1
fi

# Verify the service exists in this compose file
if ! "${dc[@]}" config --services | grep -qx "${SERVICE}"; then
  echo "ERROR: Service '${SERVICE}' not found in '${COMPOSE_FILE}'."
  echo "Services available: $(${dc[@]} config --services | tr '\n' ' ')"
  echo "Hint: set SERVICE=<name> to one of the above."
  exit 1
fi

# If a profile is specified, include it; otherwise omit flag entirely
profile_flag=()
if [[ -n "${PROFILE}" ]]; then
  profile_flag=(--profile "${PROFILE}")
fi

# Ensure the service is running (exec needs a running container)
if ! "${dc[@]}" ps --services --filter "status=running" | grep -qx "${SERVICE}"; then
  echo "INFO: '${SERVICE}' is not running — starting the service..."
  "${dc[@]}" up -d "${SERVICE}" "${profile_flag[@]}"
  # small wait to ensure healthy (optional)
  sleep 2
fi

# Figure out the DB name & root password by reading the compose-time env (fallbacks are fine)
# We'll read them inside the container to avoid leaking locally.
echo "==> Dumping \${MYSQL_DATABASE:-banterfc} (schema+data) to ${OUTFILE}"

# Perform the dump inside the mysql service container and gzip locally
# Notes:
#   --single-transaction: consistent snapshot for InnoDB without locking
#   --routines/--events/--triggers: include all programmatic objects
#   --hex-blob + utf8mb4: safe charset and binary handling
#   --set-gtid-purged=OFF + --no-tablespaces: compatibility on managed hosts
"${dc[@]}" "${profile_flag[@]}" exec -T "${SERVICE}" sh -s <<'IN_CONTAINER' | gzip -9 > "${OUTFILE}"
set -euo pipefail
# Ensure required env are present (compose passes them through)
: "${MYSQL_ROOT_PASSWORD:?MYSQL_ROOT_PASSWORD is not set in the container environment}"
DB_NAME="${MYSQL_DATABASE:-banterfc}"

mysqldump \
  -uroot -p"$MYSQL_ROOT_PASSWORD" \
  --databases "$DB_NAME" \
  --single-transaction --quick \
  --routines --events --triggers \
  --hex-blob --default-character-set=utf8mb4 \
  --set-gtid-purged=OFF \
  --column-statistics=0 \
  --no-tablespaces
IN_CONTAINER

echo "==> Done: ${OUTFILE}"

