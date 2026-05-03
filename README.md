# Aurekai Kestra

Official Kestra integration surface for Aurekai.

This repository contains reusable Kestra flows, blueprint-style examples, GitOps sync guidance, and validation scripts for orchestrating Aurekai runtime and release operations.

## What This Covers

- Runtime health and deep diagnostics (`akai doctor --deep`)
- Manifest validation and compatibility checks
- Model-memory packaging and verification
- SAE audit tasks
- Semantic cache benchmarks
- Proof bundle export
- Release gates across package and registry surfaces

## Repository Layout

- `flows/` importable Kestra flows
- `blueprints/` curated reusable examples
- `namespaces/` namespace resource specs
- `docs/` quickstart, inputs, secrets, GitOps sync
- `examples/` local Kestra bootstrap and sample manifests
- `tests/` static flow validation scripts

## Quickstart

1. Launch Kestra using `examples/docker-compose.kestra.yaml`.
2. Import a flow from `flows/`.
3. Configure required secrets.
4. Run `bash tests/validate-flows.sh` before commit.

## Related Repos

- Core platform: https://github.com/aurekai/aurekai
- Native runtime: https://github.com/aurekai/native-runtime
