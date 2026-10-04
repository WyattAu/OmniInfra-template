# OPA policy gate — runs via conftest on the plan JSON before every apply
# (estate alignment: policy-kit semantics, fail-closed).
package main

import rego.v1

deny contains msg if {
  some r in input.resource_changes
  r.mode == "managed"
  # Exemption pattern (documented, not silent): the scaffold's placeholder
  # is tag-less by design; real resources must carry tags.
  r.type != "terraform_data"
  not r.change.after.tags
  msg := sprintf("resource %s has no tags (policy: every resource is attributable)", [r.address])
}
