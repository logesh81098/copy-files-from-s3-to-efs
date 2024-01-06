module "vpc" {
  source = "./module/vpc"
}

module "s3" {
  source = "./module/s3"
}
module "security-groups" {
  source = "./module/security-groups"
  vpc-id = module.vpc.vpc-id
}

module "efs" {
  source = "./module/efs"
  subnet-1-id = module.vpc.subnet-1-id
  subnet-2-id = module.vpc.subnet-2-id
  efs-security-group = module.security-groups.efs-security-group
}