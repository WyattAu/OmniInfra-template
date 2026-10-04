#!/usr/bin/env bash
# Plan an env: ./scripts/plan.sh dev — plan artifacts are policy-gated next.
set -euo pipefail
cd "$(dirname "$0")/.."
env="${1:?usage: plan.sh <env>}"
tofu -chdir="envs/$env" init
tofu -chdir="envs/$env" plan -out="$env.tfplan"
exec ./scripts/policy.sh "envs/$env/$env.tfplan"
