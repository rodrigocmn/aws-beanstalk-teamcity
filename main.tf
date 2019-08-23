
module "iam" {
  source = "./iam"

  application_name = var.application_name
}

module "rds" {
  source = "./rds"

  application_environment = var.application_environment
  application_name        = var.application_name
  db_allocated_storage    = var.db_allocated_storage
  db_engine               = var.db_engine
  db_engine_version       = var.db_engine_version
  db_instance_type        = var.db_instance_type
  db_multi_az             = var.db_multi_az
  db_password             = var.db_password
  db_username             = var.db_username
  vnet_id                 = var.vnet_id
  resources_tags          = var.resources_tags
  db_port                 = var.db_port
}

module "beanstalk" {
  source = "./beanstalk"

  application_description = var.application_description
  application_environment = var.application_environment
  application_name        = var.application_name
  application_version     = var.application_version
  autoscaling_maxsize     = var.autoscaling_maxsize
  docker_container_port   = var.docker_container_port
  docker_host_port        = var.docker_host_port
  docker_image            = var.docker_image
  docker_tag              = var.docker_tag
  health_check            = var.health_check
  instance_type           = var.instance_type
  instance_profile        = module.iam.instance_profile
  service_role            = module.iam.service_role
  subnets                 = var.subnets
  vnet_id                 = var.vnet_id
  solution_stack_name     = var.solution_stack_name
  key_name                = var.key_name
  db_address              = module.rds.rds_address
  db_username             = var.db_username
  db_password             = var.db_password
  db_port                 = var.db_port
}