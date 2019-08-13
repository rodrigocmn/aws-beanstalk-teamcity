# Beanstalk instance profile

# Policies
data "template_file" "eb_role" {
  template = file("${path.module}/policy/teamcity_service_policy.json")
}

data "template_file" "ec2_role" {
  template = file("${path.module}/policy/teamcity_instance_policy.json")
}

# Profiles

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.application_name}-beanstalk-ec2-user"
  role = aws_iam_role.ec2.name
}

resource "aws_iam_instance_profile" "service" {
  name = "${var.application_name}-beanstalk-service-user"
  role = aws_iam_role.service.name
}


# EC2 Role and policies attachment

resource "aws_iam_role" "ec2" {
  name = "${var.application_name}-beanstalk-ec2-role"

  assume_role_policy = data.template_file.ec2_role.rendered
}

resource "aws_iam_policy_attachment" "ec2" {
  name       = "${var.application_name}-elastic-beanstalk-ec2"
  roles      = [aws_iam_role.ec2.id]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}


# Service Role and policies attachment

resource "aws_iam_role" "service" {
  name = "${var.application_name}-beanstalk-service-role"

  assume_role_policy = data.template_file.eb_role.rendered
}

resource "aws_iam_policy_attachment" "service" {
  name       = "${var.application_name}-elastic-beanstalk-service"
  roles      = [aws_iam_role.service.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
}

resource "aws_iam_policy_attachment" "service_health" {
  name       = "${var.application_name}-elastic-beanstalk-service-health"
  roles      = [aws_iam_role.service.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}