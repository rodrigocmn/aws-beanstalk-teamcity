# Network
variable "vnet_id" {}

# Database
variable "db_username" {}
variable "db_password" {}
variable "db_instance_type" {}
variable "db_engine" {}
variable "db_engine_version" {}
variable "db_port" {}
variable "db_allocated_storage" {}
variable "db_multi_az" {}

# Application Reference
variable "application_name" {}
variable "application_environment" {}

# Common
variable "resources_tags" {}