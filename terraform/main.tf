
module "iam" {
  source = "./iam"

  application_name = var.application_name
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
}