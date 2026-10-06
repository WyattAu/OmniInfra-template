# Thin wrapper over scripts/ — the same verbs in every Omni template.
.PHONY: bench bench-update repro fmt fmt-check validate lint docs policy plan contract ci clean

fmt:
	./scripts/fmt.sh

fmt-check:
	tofu fmt -check -recursive .

validate:
	./scripts/validate.sh

lint:
	./scripts/lint.sh

docs:
	./scripts/docs.sh

policy:
	./scripts/policy.sh

plan:
	./scripts/plan.sh

contract:
	./scripts/check-contract.sh

## What CI gates before merge (mirror of .github/workflows/ci.yml):
ci: contract fmt-check validate lint

repro:
	./scripts/repro-check.sh

bench:
	./scripts/bench-budget.sh

bench-update:
	./scripts/bench-budget.sh --update

clean:
	rm -f plan.json
	find . -name '.terraform' -type d -exec rm -rf {} +
