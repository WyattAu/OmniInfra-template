#!/usr/bin/env bash
# Reproducible-build check (loop 3): build twice from a clean state with a pinned
# epoch and compare artifact hashes.
#
# MODE=report - "gate" for toolchains that are deterministic (a mismatch is a
# real finding), "report" for toolchains that embed timestamps by design (a
# mismatch is printed and explained, never blocks). See the ADR.
set -euo pipefail
cd "$(dirname "$0")/.."
MODE=report
EPOCH="${SOURCE_DATE_EPOCH:-$(git log -1 --pretty=%ct 2>/dev/null || echo 0)}"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

compare() {
  if [ "$1" = "$2" ]; then
    echo "reproducible: OK ($1)"
    return 0
  fi
  echo "reproducible: MISMATCH" >&2
  echo "  run A: $1" >&2
  echo "  run B: $2" >&2
  if [ "$MODE" = "gate" ]; then
    echo "  this toolchain is expected to be deterministic - fix the build" >&2
    exit 1
  fi
  echo "  reported only: this toolchain embeds timestamps/build ids by design" >&2
  exit 0
}

# `tofu plan` serialises a run id and provider metadata into the plan file, so
# two identical plans do not hash the same. Reported, not gated.
fingerprint() {
  tofu -chdir=envs/dev init -backend=false -input=false >/dev/null
  tofu -chdir=envs/dev plan -input=false -lock=false -out="$WORK/$1.tfplan" >/dev/null
  sha256sum "$WORK/$1.tfplan" | awk '{print $1}'
}
a="$(fingerprint a)"
b="$(fingerprint b)"
compare "$a" "$b"
