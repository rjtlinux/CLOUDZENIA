module "vpc" {
  source = "./modules/vpc"

  project_name           = var.project_name
  vpc_cidr              = var.vpc_cidr
  subnet_cidr           = var.subnet_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  availability_zone     = var.availability_zone
  public_availability_zone = var.public_availability_zone
  private_subnet_2_cidr  = var.private_subnet_2_cidr
  private_subnet_2_az    = var.private_subnet_2_az
  public_subnet_2_cidr   = var.public_subnet_2_cidr
  public_subnet_2_az     = var.public_subnet_2_az
}

module "rds" {
  source = "./modules/rds"
  
  project_name        = var.project_name
  vpc_id             = module.vpc.vpc_id
  vpc_cidr           = var.vpc_cidr
  private_subnet_ids = module.vpc.private_subnet_ids
  availability_zone  = var.availability_zone
  
  database_name     = var.database_name
  database_username = var.database_username
  database_password = var.database_password
  
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  
  depends_on = [module.vpc]
}

module "ecs" {
  source = "./modules/ecs"

  project_name       = var.project_name
  aws_region        = var.aws_region
  vpc_id            = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
  secrets_arn       = module.rds.secret_arn

  depends_on = [module.rds]
} 