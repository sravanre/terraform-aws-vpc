
module "vpc" {
  source = "./modules/vpc"
}

module "web-tier" {
  source            = "./modules/web-tier"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.private_subnet_ids

}

module "app-tier" {
  source             = "./modules/app-tier"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

}

module "db-tier" {
  source        = "./modules/db-tier"
  vpc_id        = module.vpc.vpc_id
  db_subnet_ids = module.vpc.db_subnet_ids
}