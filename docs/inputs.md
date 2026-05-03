# Inputs

All flows use typed inputs to avoid hardcoded release values.

Common inputs:

- `aurekai_version`
- `runtime_package`
- `aurekai_manifest_schema`
- `helm_chart_version`
- `manifest_path`
- `artifact_dir`

Kestra expressions are referenced via `{{ inputs.<id> }}`.
