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


## Performance budgets

Performance is a gate, not a hope. `make bench` measures, writes
`bench/current.tsv`, and compares it against the committed
`bench/baseline.tsv`; anything more than the threshold worse fails. The
comparator (`scripts/compare-bench.py`) is identical across the whole Omni
estate, so the policy is auditable in one place.

| Verb | What it does |
|---|---|
| `make bench` | measure + compare (advisory job in CI: `perf`) |
| `make bench-update` | deliberately re-baseline; the only way a baseline moves |

The first run on a fresh clone records the baseline instead of failing, so the
gate is meaningful from the second run onwards. Override the budget per run
with `OMNI_BENCH_THRESHOLD_PCT=15 make bench`. Rationale and per-template
metrics: `docs/adr/0004-performance-budget-gate.md`.


## Determinism

`make repro` builds twice from a clean state with a pinned `SOURCE_DATE_EPOCH`
and compares artifact hashes. Toolchains that are deterministic gate the build;
toolchains that embed timestamps or build ids by design report the difference
and explain why, rather than pretending to be reproducible. Rationale and the
per-toolchain split: `docs/adr/0005-determinism-verification.md`.
