# Quickstart

## 1. Launch Kestra

Use [examples/docker-compose.kestra.yaml](../examples/docker-compose.kestra.yaml).

## 2. Import a flow

Try one of:

- `flows/doctor-deep.yaml`
- `flows/manifest-verify.yaml`
- `flows/release-gate.yaml`

## 3. Configure secrets

See [docs/secrets.md](./secrets.md).

## 4. Validate before commit

```bash
bash scripts/sync-release-defaults.sh
bash tests/validate-release-inputs.sh
bash tests/validate-flows.sh
```
