# Terragrunt Infrastructure Setup

## Overview

This directory for sets up an AWS infrastructure using Terraform modules and Terragrunt.  
It includes reusable modules for EC2, ALB, SNS, VPC, CloudWatch, and Auto Scaling, with separate environments (`dev`, `production`).

## Structure
```
project/
├── root.hcl # Common Terragrunt config for all environments
├── dev/
│ ├── env.hcl # Environment-specific variables
│ ├── vpc/
│ └── app/
│   ├── alb/
│   ├── asg/
│   ├── cloudwatch/
│   ├── ec2/
│   ├── sg/
│   └── sns/
├── production/
│ ├── env.hcl 
│ ├── vpc/
│ └── app/
│   ├── alb/
│   ├── asg/
│   ├── cloudwatch/
│   ├── ec2/
│   ├── sg/
│   └── sns/
├── README.md
└── modules/ # Reusable Terraform modules (ec2_template, etc.)
```
---

## How to Use

### One-time Setup

Ensure you have:

- [Terraform](https://www.terraform.io/downloads)
- [Terragrunt](https://terragrunt.gruntwork.io)
- AWS credentials configured (e.g. via `aws configure`)

---

### Deploy a Specific Component

```
cd dev/app/ec2
terragrut apply
```

### Deploy Everything in an Environment
From the environment root (dev/ or production/):

```
tg apply -all
```

###  Remote State
Each environment/module stores state in a unique S3 path:

```hcl
key = "${path_relative_to_include()}/tf.tfstate"
```

S3 bucket:
```
 5252-terragrunt-tf-state-eu-north-1
```

### Code Structure Notes

- root.hcl defines:

     1. Provider config (generated into provider.tf)

     2. Remote backend (generated into backend.tf)

     3. Shared input variables from env.hcl


- env.hcl holds environment-specific variables like:

  1. environment = "dev" or "production"
  2. Path to user data script


-  ALB and Target Group names must be unique across environments — avoid collisions (e.g. by appending env suffix)