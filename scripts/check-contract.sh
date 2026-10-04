#!/usr/bin/env bash
# Omni Core Contract checks (THREAT-MODEL T4/T5) — same shape in every Omni.
set -euo pipefail
cd "$(dirname "$0")/.."
fail=0

for wf in .github/workflows/*.yml .forgejo/workflows/*.yml; do
  grep -q 'permissions:' "$wf" || { echo "FAIL: $wf missing explicit permissions block"; fail=1; }
done

while read -r script; do
  [ -x "$script" ] || { echo "FAIL: Makefile references missing script $script"; fail=1; }
done < <(grep -oP '(?<=^	)(scripts/[a-z-]+\.sh)' Makefile | sort -u)

# tfvars with real values must never be committed
if find envs -name 'terraform.tfvars' -not -name '*.example' | grep -q .; then
  echo "FAIL: committed terraform.tfvars (REQ-T-100)"; fail=1
fi

[ "$fail" -eq 0 ] && echo "contract: OK"
exit "$fail"
