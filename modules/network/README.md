<!-- terraform-docs: keep this block maintained via `make docs` -->
# network

Example module skeleton. Replace the placeholder resource with real
infrastructure; keep one concern per module.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [terraform_data.this](https://developer.hashicorp.com/terraform/language/resources/terraform-data) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | VPC CIDR block. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Network name; also the tag key prefix. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Placeholder id — replace with a real resource. |
<!-- END_TF_DOCS -->
