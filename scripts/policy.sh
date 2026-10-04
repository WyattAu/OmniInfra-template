#!/usr/bin/env bash
# conftest over a plan file: fail-closed OPA gate. Usage: ./scripts/policy.sh plan.json
set -euo pipefail
cd "$(dirname "$0")/.."
plan="${1:?usage: policy.sh <plan.json>}"
tofu show -json "$plan" > plan.json
conftest test plan.json --policy policies/
