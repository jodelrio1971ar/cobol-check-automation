#!/usr/bin/env bash
set -e

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
PROGRAM="${1:-EMPPAY}"
TMP_CONFIG="$(mktemp)"

trap 'rm -f "$TMP_CONFIG"' EXIT

sed \
  -e "s#/home/jodelrio/kiro/cobol-check-automation#${ROOT}#g" \
  "$ROOT/cobol-check/config.properties" > "$TMP_CONFIG"

mkdir -p "$ROOT/cobol-check/testruns"

java -jar "$ROOT/cobol-check/bin/cobol-check-0.2.19.jar" \
  -c "$TMP_CONFIG" \
  -s "$ROOT" \
  -r "$ROOT/cobol-check" \
  -p "$PROGRAM"
