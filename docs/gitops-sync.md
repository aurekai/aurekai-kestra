# GitOps Sync

Use Git-based sync so official Aurekai flows cannot drift or disappear.

## Source repository

- https://github.com/aurekai/aurekai-kestra

## Reference flow

- `flows/sync-aurekai-flows.yaml`

## Suggested parameters

- `repo_url`: `https://github.com/aurekai/aurekai-kestra`
- `branch`: `main`
- `target_namespace`: `aurekai.runtime`

Use Kestra SyncFlows in your instance with a Git PAT and branch pin.
