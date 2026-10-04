#!/usr/bin/env bash
# terraform-docs over every module; CI fails if docs drift (make ci).
# --output-file is resolved RELATIVE to the module dir, hence plain README.md.
set -euo pipefail
cd "$(dirname "$0")/.."
for m in modules/*/; do
  terraform-docs markdown table --output-file README.md --output-mode inject "$m"
done
