#!/usr/bin/env bash
set -euo pipefail

JOBID="${1:-}"

if [[ -z "$JOBID" ]]; then
  echo "Uso: $0 <jobid>" >&2
  exit 2
fi

if [[ ! "$JOBID" =~ ^[A-Za-z0-9]+$ ]]; then
  echo "Error: jobid no válido: $JOBID" >&2
  exit 2
fi

echo "Estado del job ${JOBID}:"
zowe jobs view job-status-by-jobid "$JOBID"

echo
echo "Spool completo del job ${JOBID}:"
zowe jobs view all-spool-content "$JOBID"
