# Load environment-specific variables from the nearest env.hcl in the directory tree
locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  aws_region = "eu-north-1"
}

# Generate a provider.tf file to configure the AWS provider
# And not to define provider.tf for every unit
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
}
EOF
}

# Configure remote state backend using S3
# Use generate not define backend.tf for every unit
remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket  = "5252-terragrunt-tf-state-${local.aws_region}"
    key     = "${path_relative_to_include()}/tf.tfstate"
    region  = local.aws_region
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Pass environment-specific variables to Terraform modules
inputs = local.environment_vars.locals