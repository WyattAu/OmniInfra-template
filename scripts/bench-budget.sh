#!/usr/bin/env bash
# Perf budget gate: measure, emit bench/current.tsv, compare to the committed
# baseline with the shared comparator. `make bench-update` re-baselines
# deliberately - it is the only way a baseline moves.
set -euo pipefail
cd "$(dirname "$0")/.."
BASELINE=bench/baseline.tsv
CURRENT=bench/current.tsv
THRESHOLD_PCT="${OMNI_BENCH_THRESHOLD_PCT:-20}"
UPDATE=()
[ "${1:-}" = "--update" ] && UPDATE=(--update)
mkdir -p bench

# Infrastructure has no request hot path; the cost a contributor feels is how
# long the full local gate takes (fmt + validate + lint + policy). Budgeted so
# a slow gate gets noticed before it becomes normal.
now_ms() {
  python3 -c 'import time; print(int(time.time() * 1000))'
}


start="$(now_ms)"
make fmt-check validate lint >/dev/null
end="$(now_ms)"

printf 'gate-ms\t%s\tms\tinfo\n' "$((end - start))" > "$CURRENT"

python3 scripts/compare-bench.py "$BASELINE" "$CURRENT" \
  --threshold-pct "$THRESHOLD_PCT" "${UPDATE[@]+"${UPDATE[@]}"}"
