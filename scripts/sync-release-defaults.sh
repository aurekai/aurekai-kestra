#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VARS_FILE="${1:-$ROOT_DIR/.release-versions.env}"

if [[ ! -f "$VARS_FILE" ]]; then
  echo "missing version file: $VARS_FILE" >&2
  exit 1
fi

set -a
# shellcheck disable=SC1090
source "$VARS_FILE"
set +a

for v in AUREKAI_VERSION AKAI_PACKAGE_VERSION AUREKAI_MANIFEST_SCHEMA HELM_CHART_VERSION; do
  if [[ -z "${!v:-}" ]]; then
    echo "missing required variable: $v" >&2
    exit 1
  fi
done

ROOT_DIR="$ROOT_DIR" python3 << 'PY'
from pathlib import Path
import re
import os

root = Path(os.environ['ROOT_DIR'])
flows = sorted((root / 'flows').glob('*.yaml'))

targets = {
    'aurekai_version': os.environ['AUREKAI_VERSION'],
    'akai_package_version': os.environ['AKAI_PACKAGE_VERSION'],
    'aurekai_manifest_schema': os.environ['AUREKAI_MANIFEST_SCHEMA'],
    'helm_chart_version': os.environ['HELM_CHART_VERSION'],
}

for fp in flows:
    lines = fp.read_text().splitlines()
    current_id = None
    for i, line in enumerate(lines):
      m = re.match(r'^\s*- id:\s*(\S+)\s*$', line)
      if m:
        current_id = m.group(1)
        continue
      if current_id in targets and re.match(r'^\s*defaults:\s*', line):
        indent = re.match(r'^(\s*)defaults:', line).group(1)
        lines[i] = f'{indent}defaults: "{targets[current_id]}"'
        current_id = None

    fp.write_text('\n'.join(lines) + '\n')

print(f'updated {len(flows)} flow files')
PY

echo "release defaults synced from $VARS_FILE"
