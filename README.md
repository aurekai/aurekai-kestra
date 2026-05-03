<p align="center">
  <img src="https://raw.githubusercontent.com/aurekai/aurekai/main/assets/aurekai-logo.svg" alt="Aurekai" width="520" />
</p>

# `aurekai-kestra` · v0.8.0-alpha.5

Official Kestra integration for Aurekai — 12 flows, 4 blueprints, namespace MCP resource, end-to-end capability pipeline.

## Flows

| Flow | Namespace | Description |
|---|---|---|
| `aurekai_doctor_deep` | `aurekai.runtime` | Install runtime + deep diagnostics |
| `aurekai_manifest_verify` | `aurekai.runtime` | Validate `artifact.json` |
| `aurekai_model_memory_pack` | `aurekai.runtime` | FPQ compress + pack model memory |
| `aurekai_sae_audit` | `aurekai.runtime` | SAE feature audit |
| `aurekai_semantic_cache_bench` | `aurekai.bench` | Cache hit rate / latency benchmark |
| `aurekai_proof_bundle_export` | `aurekai.runtime` | Export `.akproof` bundle |
| `aurekai_release_gate` | `aurekai.release` | Registry + SLI + proof release gate |
| `aurekai_capability_pipeline` | `aurekai.runtime` | **Full end-to-end chain** (all 7 steps) |
| `sync_aurekai_flows` | `aurekai.dev` | GitOps flow sync from this repo |
| `npm_release_check` | `aurekai.release` | Verify npm packages published |
| `pypi_release_check` | `aurekai.release` | Verify PyPI package published |
| `hf_model_memory_publish` | `aurekai.release` | Publish model to HuggingFace |

## Namespace Resources

| File | Namespace | Description |
|---|---|---|
| `aurekai-mcp.yaml` | `aurekai.runtime` | MCP server container + variable defaults |
| `aurekai.dev.yaml` | `aurekai.dev` | Dev environment variables |
| `aurekai.release.yaml` | `aurekai.release` | Release environment variables |
| `aurekai.bench.yaml` | `aurekai.bench` | Benchmark environment variables |

## Full Pipeline Flow

`aurekai_capability_pipeline` chains all operators in order:

```
install_runtime → doctor_deep → manifest_verify → model_memory_pack
→ sae_audit → semantic_cache_bench → proof_bundle_export → release_gate
→ pipeline_summary
```

Each step captures JSON output. A final Python task collects all results into a single `pipeline-summary.json` artifact.

## Quick Start

```bash
# Start Kestra
docker run -p 8080:8080 kestra/kestra:latest server standalone

# Import flows
curl -X POST http://localhost:8080/api/v1/flows/import \
  -F fileUpload=@flows/capability-pipeline.yaml

# Run via UI or:
curl -X POST http://localhost:8080/api/v1/executions/aurekai.runtime/aurekai_capability_pipeline
```

## Layout

```
flows/         12 importable Kestra flow YAML files
blueprints/    4 curated reusable examples
namespaces/    4 namespace resource specs (incl. MCP)
docs/          quickstart, inputs, secrets, GitOps
examples/      local bootstrap docker-compose + sample manifests
tests/         static flow validation scripts
scripts/       release version sync helper
```


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

## Release Version Sync

Shared release defaults are centralized in `.release-versions.env`:

- `AUREKAI_VERSION`
- `AKAI_PACKAGE_VERSION`
- `AUREKAI_MANIFEST_SCHEMA`
- `HELM_CHART_VERSION`

Sync all flow defaults with one command:

```bash
bash scripts/sync-release-defaults.sh
```

Validate release inputs across all flows:

```bash
bash tests/validate-release-inputs.sh
```

## Related Repos

- Core platform: https://github.com/aurekai/aurekai
- Native runtime: https://github.com/aurekai/native-runtime
