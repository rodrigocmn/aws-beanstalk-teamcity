data "aws_vpc" "rds_vpc" {
  id = var.vnet_id
}

data "aws_subnet_ids" "rds_subnets" {
  vpc_id = data.aws_vpc.rds_vpc.id

  Use this filter to deploy RDS to Private subnets
  You will need to tag you subnet first and then 
//  tags = {
//    Network = "Private"
//  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.application_name}-${var.application_environment}-rds-subnet-group"
  description = "The ${var.application_name} rds private subnet group."
  subnet_ids  = data.aws_subnet_ids.rds_subnets.ids

  tags = var.resources_tags
}

resource "aws_security_group" "rds_security_group" {
  name        = "${var.application_name}-${var.application_environment}-all-rds-internal"
  description = "Allow all vpc traffic to rds."
  vpc_id      = data.aws_vpc.rds_vpc.id

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.rds_vpc.cidr_block]
  }

  tags = var.resources_tags
}

resource "aws_db_instance" "rds_instance" {
  depends_on              = ["aws_db_subnet_group.rds_subnet_group"]
  name                    = "${var.application_name}db"
  identifier              = "${var.application_environment}-${var.application_name}-${var.db_engine}"
  allocated_storage       = var.db_allocated_storage
  storage_type            = "gp2"
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_type
  multi_az                = var.db_multi_az
  username                = var.db_username
  password                = var.db_password
  vpc_security_group_ids  = [aws_security_group.rds_security_group.id]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.id
  skip_final_snapshot     = true
  backup_retention_period = 3
}


