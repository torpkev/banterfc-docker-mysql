#!/usr/bin/env bash
set -euo pipefail

# Uses Docker Compose env + dev profile.
ENV_FILE=".env"
PROFILE="dev"
SERVICE="mysql"

STAMP="$(date +%F_%H%M%S)"
OUTDIR="backups/schema"
OUTFILE="${OUTDIR}/banterfc_schema_${STAMP}.sql.gz"

mkdir -p "${OUTDIR}"

echo "==> Dumping schema (no data) to ${OUTFILE}"

docker compose --env-file "${ENV_FILE}" --profile "${PROFILE}" exec -T "${SERVICE}" \
  sh -c '
    mysqldump \
      -uroot -p"$MYSQL_ROOT_PASSWORD" \
      --databases "$MYSQL_DATABASE" \
      --no-data \
      --routines --events --triggers \
      --default-character-set=utf8mb4 \
      --set-gtid-purged=OFF \
      --column-statistics=0 \
      --no-tablespaces
  ' | gzip -9 > "${OUTFILE}"

echo "==> Done: ${OUTFILE}"

