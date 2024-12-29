
module "vpc" {
  source = "./modules/vpc"
}

module "web-tier" {
  source            = "./modules/web-tier"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids

}

module "app-tier" {
  source             = "./modules/app-tier"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  aws_security_group_web_id = module.web-tier.aws_security_group_web_id


}

module "db-tier" {
  source        = "./modules/db-tier"
  vpc_id        = module.vpc.vpc_id
  db_subnet_ids = module.vpc.db_subnet_ids
  aws_security_group_app_id = module.app-tier.aws_security_group_app_id
}