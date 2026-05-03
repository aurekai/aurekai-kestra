#!/usr/bin/env bash
set -euo pipefail

fail=0
for f in flows/*.yaml blueprints/*.yaml; do
  grep -q '^id:' "$f" || { echo "missing id: $f"; fail=1; }
  grep -q '^namespace:' "$f" || { echo "missing namespace: $f"; fail=1; }
  grep -q '^tasks:' "$f" || { echo "missing tasks: $f"; fail=1; }
done

if [[ "$fail" -ne 0 ]]; then
  echo "flow validation failed"
  exit 1
fi

echo "flow validation passed"
