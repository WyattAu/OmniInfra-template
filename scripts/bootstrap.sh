#!/usr/bin/env bash
# Non-nix fallback. Canonical env: flake.nix (tofu + gate tools).
set -euo pipefail
cat <<'MSG'
Manual toolchain (no nix):
  1. opentofu, tflint, conftest, terraform-docs, trivy (package manager or
     official installers)
  2. make ci
Prefer zero setup? Open the repo in a devcontainer, or `nix develop`.
MSG
