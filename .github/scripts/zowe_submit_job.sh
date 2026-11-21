#!/usr/bin/env bash
set -euo pipefail

JCL_DATASET="${ZOWE_JCL_DATASET:-Z79580.JCL}"
MEMBER="${1:-}"

if [[ -z "$MEMBER" ]]; then
  echo "Uso: $0 <miembro-JCL>" >&2
  exit 2
fi

if [[ ! "$MEMBER" =~ ^[A-Za-z0-9#@$]+$ ]]; then
  echo "Error: nombre de miembro JCL no válido: $MEMBER" >&2
  exit 2
fi

echo "Sometiendo ${JCL_DATASET}(${MEMBER}) mediante Zowe..."
zowe jobs submit data-set "${JCL_DATASET}(${MEMBER})"
