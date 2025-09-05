#!/usr/bin/env bash
set -euo pipefail

ENV_FILE=".env"
PROFILE="dev"
SERVICE="mysql"

STAMP="$(date +%F_%H%M%S)"
OUTDIR="backups/full"
OUTFILE="${OUTDIR}/banterfc_full_${STAMP}.sql.gz"
mkdir -p "${OUTDIR}"

echo "==> Dumping ${MYSQL_DATABASE:-banterfc} (schema+data) to ${OUTFILE}"

docker compose --env-file "${ENV_FILE}" --profile "${PROFILE}" exec -T "${SERVICE}" \
  sh -c '
    mysqldump \
      -uroot -p"$MYSQL_ROOT_PASSWORD" \
      --databases "$MYSQL_DATABASE" \
      --single-transaction --quick \
      --routines --events --triggers \
      --hex-blob --default-character-set=utf8mb4 \
      --set-gtid-purged=OFF \
      --column-statistics=0 \
      --no-tablespaces
  ' | gzip -9 > "${OUTFILE}"

echo "==> Done: ${OUTFILE}"

