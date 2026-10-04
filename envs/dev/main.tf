# Environment: dev. Backend + provider pins live here; values in tfvars.
# Remote backend (s3/azurerm/gcs) is a per-estate decision — scaffold a
# backend block when the first real env lands.
module "network" {
  source = "../../modules/network"
  name   = "omni-dev"
  cidr   = "10.10.0.0/16"
}
