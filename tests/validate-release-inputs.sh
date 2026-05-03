#!/usr/bin/env bash
set -euo pipefail

required=(
  aurekai_version
  akai_package_version
  aurekai_manifest_schema
  helm_chart_version
)

fail=0
for f in flows/*.yaml; do
  for key in "${required[@]}"; do
    if ! grep -q -- "- id: ${key}$" "$f"; then
      echo "missing release input ${key}: $f"
      fail=1
    fi
  done
done

if [[ "$fail" -ne 0 ]]; then
  echo "release input validation failed"
  exit 1
fi

echo "release input validation passed"
