#!/usr/bin/env bash
set -euo pipefail

TARGET_TYPE="${1:-}"
LOCAL_FILE="${2:-}"
REMOTE_TARGET="${3:-}"

if [[ -z "$TARGET_TYPE" || -z "$LOCAL_FILE" || -z "$REMOTE_TARGET" ]]; then
  echo "Uso: $0 <uss|data-set> <archivo-local> <destino-remoto>" >&2
  exit 2
fi

if [[ "$TARGET_TYPE" != "uss" && "$TARGET_TYPE" != "data-set" ]]; then
  echo "Error: tipo de destino no válido: $TARGET_TYPE" >&2
  echo "Valores permitidos: uss, data-set" >&2
  exit 2
fi

if [[ ! -f "$LOCAL_FILE" ]]; then
  echo "Error: archivo local no encontrado: $LOCAL_FILE" >&2
  exit 2
fi

case "$TARGET_TYPE" in
  uss)
    echo "Subiendo ${LOCAL_FILE} a USS ${REMOTE_TARGET}..."
    zowe zos-files upload file-to-uss "$LOCAL_FILE" "$REMOTE_TARGET"
    ;;
  data-set)
    echo "Subiendo ${LOCAL_FILE} al dataset ${REMOTE_TARGET}..."
    zowe zos-files upload file-to-data-set "$LOCAL_FILE" "$REMOTE_TARGET"
    ;;
esac
