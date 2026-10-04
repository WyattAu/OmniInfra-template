# Example module: the estate pattern — one concern per module, documented
# by terraform-docs, policy-checked by conftest before plan/apply.
# Uses terraform_data (built-in provider) so the scaffold plans with zero
# provider configuration; swap for real resources per concern.

variable "name" {
  type        = string
  description = "Network name; also the tag key prefix."
}

variable "cidr" {
  type        = string
  description = "VPC CIDR block."
}

resource "terraform_data" "this" {
  input = {
    name = var.name
    cidr = var.cidr
  }
}

output "id" {
  value       = terraform_data.this.id
  description = "Placeholder id — replace with a real resource."
}
