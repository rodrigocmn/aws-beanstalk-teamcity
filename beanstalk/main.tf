# Create Single Container Docker Configuration from template
data "template_file" "docker" {
  template = file("${path.module}/templates/Dockerrun.aws.json.tpl")

  vars = {
    docker_tag            = var.docker_tag
    docker_image          = var.docker_image
    docker_host_port      = var.docker_host_port
    docker_container_port = var.docker_container_port
    db_address            = var.db_address
    db_name               = "${var.application_name}db"
    db_port               = var.db_port
    db_username           = var.db_username
    db_password           = var.db_password
  }
}

data "archive_file" "zip" {
  type = "zip"

  source_content          = data.template_file.docker.rendered
  source_content_filename = "Dockerrun.aws.json"
  output_path             = "./${var.application_name}-Dockerrun.zip"
}

resource "aws_s3_bucket" "default" {
  bucket = "${var.application_name}-beanstalk-deployments"
}

resource "aws_s3_bucket_object" "default" {
  bucket = aws_s3_bucket.default.bucket
  key    = "${var.application_name}-Dockerrun"
  source = "./${var.application_name}-Dockerrun.zip"
  etag   = data.archive_file.zip.output_md5
}

# Beanstalk Application

resource "aws_elastic_beanstalk_application" "default" {
  name        = var.application_name
  description = var.application_description
}


resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "${var.application_name}-${var.application_version}"
  application = var.application_name
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.default.id
  key         = aws_s3_bucket_object.default.id

  lifecycle {
    create_before_destroy = true
  }
}

# Beanstalk Environment




resource "aws_elastic_beanstalk_environment" "default" {
  name                = "${var.application_name}-${var.application_environment}"
  application         = aws_elastic_beanstalk_application.default.name
  solution_stack_name = var.solution_stack_name
  version_label       = aws_elastic_beanstalk_application_version.default.name


  # Network
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vnet_id
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.subnets)
  }

  setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "true"
  }


  # Instance
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"

    value = "SingleInstance"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"

    value = var.instance_type
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"

    value = var.key_name
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"

    value = var.autoscaling_maxsize
  }

//  Use this setting for custom or older AMIs
//  setting {
//    namespace = "aws:autoscaling:launchconfiguration"
//    name = "ImageId"
//    value = "ami-08777ea4f42d1a462"
//  }

  # Security
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.instance_profile
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = var.service_role
  }



  //  setting {
  //    namespace = "aws:elasticbeanstalk:application"
  //    name      = "Application Healthcheck URL"
  //    value     = var.health_check
  //  }
  //
  //  setting {
  //    namespace = "aws:elasticbeanstalk:healthreporting:system"
  //    name      = "SystemType"
  //    value     = "enhanced"
  //  }

  # Rolling updates and deployments
  //  setting {
  //    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
  //    name      = "RollingUpdateEnabled"
  //    value     = "true"
  //  }
  //
  //  setting {
  //    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
  //    name      = "RollingUpdateType"
  //    value     = "Health"
  //  }
  //
  //  setting {
  //    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
  //    name      = "MinInstancesInService"
  //    value     = "1"
  //  }
  //
  //  setting {
  //    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
  //    name      = "MaxBatchSize"
  //    value     = "1"
  //  }
  //
  //  setting {
  //    namespace = "aws:elasticbeanstalk:command"
  //    name      = "BatchSizeType"
  //    value     = "Fixed"
  //  }
  //
  //  setting {
  //    namespace = "aws:elasticbeanstalk:command"
  //    name      = "BatchSize"
  //    value     = "1"
  //  }
  //
  //  setting {
  //    namespace = "aws:elasticbeanstalk:command"
  //    name      = "DeploymentPolicy"
  //    value     = "Rolling"
  //  }
  //
  //  setting {
  //    namespace = "aws:elb:policies"
  //    name      = "ConnectionDrainingEnabled"
  //    value     = "true"
  //  }

  // TODO - We're not currently using ELB (commented for future use)
  //
  // setting {
  //    namespace = "aws:ec2:vpc"
  //    name      = "ELBScheme"
  //    value     = "${var.elb_scheme}"
  //  }


  # TODO - implement environment variables
  //  setting {
  //    namespace = "aws:elasticbeanstalk:application:environment"
  //    name      = "${element(var.env_vars, 0)}"
  //    value     = "${element(var.env_vars, 1)}"
  //  }
  //
  //  setting {
  //    namespace = "aws:elasticbeanstalk:application:environment"
  //    name      = "${element(var.env_vars, 2)}"
  //    value     = "${element(var.env_vars, 3)}"
  //  }
  //
  //  setting {
  //    namespace = "aws:elasticbeanstalk:application:environment"
  //    name      = "${element(var.env_vars, 4)}"
  //    value     = "${element(var.env_vars, 5)}"
  //  }
}

