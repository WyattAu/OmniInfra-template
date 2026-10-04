# OmniInfra-template

Maximalist OpenTofu **infrastructure** template: modules/ + envs/ layout,
tflint (recommended preset), **fail-closed conftest/OPA policy gate** on
every plan, terraform-docs with drift enforcement, sops+age secret pattern,
human-gated apply via GH environments — nix flake + dual devcontainers.
Part of the [WyattAu Omni family](https://github.com/WyattAu?tab=repositories&q=omni-).

## Start here

1. `modules/network` and `envs/dev` are skeletons — replace with your estate
   (TrueNAS/traefik/k8s patterns from SimpleInfrastructureStack map 1:1).
2. Door: nix+direnv / devcontainer(image|nix) — `./scripts/bootstrap.sh` for manual.
3. `make ci` — fmt, validate, tflint, docs-drift, contract.

## Make targets

| Target | Gate |
|---|---|
| `make fmt` / `fmt-check` | tofu fmt |
| `make validate` | tofu init -backend=false + validate (cred-free) |
| `make lint` | tflint --recursive |
| `make docs` | terraform-docs per module (CI fails on drift) |
| `make plan ENV=dev` | plan + conftest policy gate |
| `make contract` / `make ci` | contract / contract+fmt+validate+lint |

## Apply policy

Apply is **never** run by CI. The `plan` job (owner-only) runs cred-gated
plans; merges to `envs/*` land behind the `dev-apply` GH environment for
manual approval (ADR-0001). Secrets: sops+age for files, GH environment
secrets for providers.

## License

Apache-2.0 — commercial use expressly permitted.
