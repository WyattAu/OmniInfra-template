# tflint — provider-agnostic rules first; enable provider plugins per env.
plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

rule "terraform_required_version" { enabled = true }
rule "terraform_naming_convention" { enabled = true }
rule "terraform_documented_variables" { enabled = true }
rule "terraform_documented_outputs" { enabled = true }
