# Network

variable "vnet_id" {}
variable "subnets" {}


variable "docker_tag" {}
variable "docker_image" {}
variable "docker_container_port" {}
variable "docker_host_port" {}

variable "application_name" {}
variable "application_description" {}
variable "application_version" {}
variable "application_environment" {}


# Launch configuration
variable "instance_type" {}
variable "key_name" {}
variable "autoscaling_maxsize" {}
variable "health_check" {}

variable "instance_profile" {}
variable "service_role" {}

variable "solution_stack_name" {}

# DB config
variable "db_address" {}
variable "db_port" {}
variable "db_username" {}
variable "db_password" {}