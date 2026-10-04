#!/usr/bin/env bash
# terraform-docs over every module; CI fails if docs drift (make ci).
set -euo pipefail
cd "$(dirname "$0")/.."
for m in modules/*/; do
  terraform-docs markdown table --output-file "$m/README.md" --output-mode inject "$m"
done
