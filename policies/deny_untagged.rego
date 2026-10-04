# OPA policy gate — runs via conftest on the plan JSON before every apply
# (estate alignment: policy-kit semantics, fail-closed).
package main

deny contains msg if {
  some r in input.resource_changes
  r.mode == "managed"
  not r.change.after.tags
  msg := sprintf("resource %s has no tags (policy: every resource is attributable)", [r.address])
}
