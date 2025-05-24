terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

module "vpc" {
  source   = "./modules/vpc"
  private_subnet_cidr_blocks = ["10.1.2.0/24", "10.1.4.0/24"]
  public_subnet_cidr_blocks = ["10.1.1.0/24"]
  subnet_az = ["eu-north-1a", "eu-north-1b"]
  vpc_cidr = "10.1.0.0/16"
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}


module "docdb" {
  source                = "./modules/docdb"
  docdb_instance_class  = "db.t3.medium"
  docdb_instance_count  = "1"
  docdb_master_password = "password"
  docdb_master_username = "master"
  docdb_sg              = module.sg.docdb_sg_id
  private_subnets       = module.vpc.private_subnets
}

module "secret_manager" {
  source                       = "./modules/secret_manager"
  docdb_master_password        = module.docdb.docdb_master_password
  docdb_master_username        = module.docdb.docdb_master_username
  task3_docdb_cluster_endpoint = module.docdb.task3_docdb_cluster_endpoint
}

module "iam" {
  source                 = "./modules/iam"
  task3_docdb_secret_arn = module.secret_manager.task3_docdb_secret_arn
}

module "ec2" {
  source               = "./modules/ec2"
  ec2_instance_profile = module.iam.instance_profile_name
  ec2_sg_id            = module.sg.ec2_sg_id
  path_to_user_data = file("../user_data/user-data.sh")
  subnet_id            = module.vpc.public_subnets[0]
  depends_on = [
    module.secret_manager
  ]
}