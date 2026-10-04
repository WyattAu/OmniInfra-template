<!-- terraform-docs: keep this block maintained via `make docs` -->
# network

Example module skeleton. Replace the placeholder resource with real
infrastructure; keep one concern per module.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [terraform_data.this](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | VPC CIDR block. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Network name; also the tag key prefix. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Placeholder id — replace with a real resource. |
| <a name="output_summary"></a> [summary](#output\_summary) | Human-readable summary for plan review. |
<!-- END_TF_DOCS -->
