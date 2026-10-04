#!/usr/bin/env bash
# init (no backend) + validate — runs anywhere, no credentials.
set -euo pipefail
cd "$(dirname "$0")/.."
tofu init -backend=false
exec tofu validate .
