# JetBrains Teamcity Deployment on AWS Beanstalk

This example shows how to deploy JetBrains TeamCity on AWS Beanstalk using terraform. 

## Overview

This terraform code creates a AWS Elastic Beanstalk application and deploys [TeamCity official docker image](https://hub.docker.com/r/jetbrains/teamcity-server/).

## Variables

| Name                    | Type   | Description                                           | Required |
| ----                    | ----   | -----------                                           | -------- | 
| vnet_id                 | String | Target VPC to deploy Elastic Beanstalk App            | yes      |
| subnets                 | List   | Target subnet to deploy Elastic Beanstalk App         | yes      |
| application_name        | String | Beanstalk Application Name                            | no       |
| application_description | String | Beanstalk Application Description                     | no       |
| application_environment | String | Target environment (i.e. dev, test, prod...)          | yes      |
| application_version     | String | Deployment version                                    | yes      |
| solution_stack_name     | String | Beanstalk Platform                                    | yes      |
| docker_tag              | String | Tag for TeamCity docker image to be deployed          | no       |
| docker_image            | List   | TeamCity Image name for the docker deployment         | no       |
| docker_container_port   | String | TeamCity container port                               | no       |
| docker_host_port        | String | Port to expose TeamCity Server                        | no       |
| instance_type           | String | AWS instance type to deploy                           | no       |
| autoscaling_maxsize     | String | Maximum instances in the autoscaling group default: 3 | no       |
| env_vars                | List   | List of docker environment variables                  | no       |




## Outputs

| Name         | Type   | Description               |
| ----         | ----   | -----------               |
| teamcity_url | String | Teamcity URL              |



## How to use it



### Directly from Github

Just refer to this repository as a module. For example:

```terraform
module "teamcity-beanstalk" {
  source = "https://github.com/rodrigocmn/aws-beanstalk-teamcity.git"
  
  application_environment = "dev"
  application_version     = "0.1"
  solution_stack_name     = "64bit Amazon Linux 2018.03 v2.12.16 running Docker 18.06.1-ce"
  subnets                 = "[sub-343452353]"
  vnet_id                 = "vpc-23453453"
}
```

### Cloned repo

Clone this repository

```git
git clone https://github.com/rodrigocmn/aws-beanstalk-teamcity.git
```

Execute the usual terraform commands

```bash
cd terraform init
cd terraform plan
cd terraform apply
```