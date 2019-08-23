output "instance_profile" {
  value = aws_iam_instance_profile.instance.name
}

output "service_role" {
  value = aws_iam_role.service.name
}