output "teamcity_url" {
  value = module.beanstalk.cname
}

output "teamcity_db_address" {
  value = module.rds.rds_address
}

output "teamcity_db_port" {
  value = module.rds.rds_port
}