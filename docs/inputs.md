# Inputs

All flows use typed inputs to avoid hardcoded release values.

Canonical release inputs present in every flow:

- `aurekai_version` <- `AUREKAI_VERSION`
- `akai_package_version` <- `AKAI_PACKAGE_VERSION`
- `aurekai_manifest_schema` <- `AUREKAI_MANIFEST_SCHEMA`
- `helm_chart_version` <- `HELM_CHART_VERSION`

Common inputs:

- `aurekai_version`
- `akai_package_version`
- `aurekai_manifest_schema`
- `helm_chart_version`
- `manifest_path`
- `artifact_dir`

Kestra expressions are referenced via `{{ inputs.<id> }}`.

To update all release defaults at once:

```bash
bash scripts/sync-release-defaults.sh
```
