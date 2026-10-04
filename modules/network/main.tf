# Example module: the estate pattern — one concern per module, documented
# by terraform-docs, policy-checked by conftest before plan/apply.
variable "name" {
  type        = string
  description = "Network name; also the tag key prefix."
}

variable "cidr" {
  type        = string
  description = "VPC CIDR block."
}

resource "taggable_placeholder" "this" {
  name = var.name
  cidr = var.cidr
}

output "id" {
  value       = taggable_placeholder.this.id
  description = "Placeholder id — replace with a real resource."
}
