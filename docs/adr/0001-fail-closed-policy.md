# 0001 — Fail-closed policy gate (conftest/OPA)

Date: 2026-10-04

## Status

Accepted

## Context

Plan reviews miss tag/encryption/networking drift by nature — humans scan,
policies don't. The estate already runs Rego semantics in policy-kit.

## Decision

Every plan is conftest-gated before it can be applied: `policies/*.rego`
deny by default on missing tags and on any new "public" attribute. A plan
that fails policy cannot reach the apply environment.

## Consequences

- Apply is always human-approved (GH environment); policy is the pre-filter.
- New governance rules = new .rego file + test, not a checklist item.
