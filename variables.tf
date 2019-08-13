# Network
variable "vnet_id" {
  description = "target VPC to deploy Elastic Beanstalk App"
  type        = "string"
//  default     = "vpc-65817700"
}

variable "subnets" {
  description = "target VPC to deploy Elastic Beanstalk App"
  type        = "list"
//  default     = ["subnet-a473a4c1"]
}

variable "application_name" {
  description = "Name of your application"
  type        = "string"
  default     = "teamcity"
}

variable "application_description" {
  description = "Sample application based on Elastic Beanstalk & Docker"
  type        = "string"
  default     = "Teamcity Server"
}

variable "application_environment" {
  description = "Deployment stage e.g. 'dev', 'test', 'prod'"
  type        = "string"
//  default     = "dev"
}

variable "application_version" {
  description = "Version number for the application"
  type        = "string"
//  default     = "0.1"
}

variable "solution_stack_name" {
  description = "Solution stacks can be listed using the following aws cli command: aws elasticbeanstalk list-available-solution-stacks"
  type        = "string"
//  default     = "64bit Amazon Linux 2018.03 v2.12.16 running Docker 18.06.1-ce"
}

# Docker variables
variable "docker_tag" {
  description = "Tag for the docker image to be deployed"
  type        = "string"
  default     = "latest"
}

variable "docker_image" {
  description = "Image name for the docker image to be deployed"
  type        = "string"
  default     = "jetbrains/teamcity-server"
}

variable "docker_container_port" {
  description = "Docker application internal port"
  type        = "string"
  default     = "8111"
}

variable "docker_host_port" {
  description = "Docker port to expose"
  type        = "string"
  default     = "80"
}

variable "instance_type" {
  description = "Type of the instance to deploy, e.g. t2.medium"
  type        = "string"
  default     = "t2.large"
}

// We're not using ELB (commented for future use)
//
//variable "elb_scheme" {
//  description = "Scheme for the ELB, internal, external"
//  default     = "external"
//}

variable "autoscaling_maxsize" {
  description = "Maximum size for the autoscaling group"
  default     = "1"
}

variable "health_check" {
  description = "Container endpoint to use for health checks"
  type        = "string"
  default     = "http://localhost:8111"
}

variable "env_vars" {
  description = "Environment variables"
  type        = "list"
  default     = []
}