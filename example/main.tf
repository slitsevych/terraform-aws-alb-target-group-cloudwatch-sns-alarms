locals {
  region    = "us-east-2"
  sns_topic = "YOUR SNS TOPIC ARN"
  alb_name  = "YOUR ALB NAME"                                  
  tg_name   = "YOUR ALB TG NAME"      
}

provider "aws" {
  region = local.region
}

data "aws_lb" "my_alb" {
  name = local.alb_name
}

data "aws_lb_target_group" "my_alb_tg" {
  name = local.tg_name
}

module "alb_target_group_cloudwatch_sns_alarms" {
  source                  = "../"
  name_prefix             = data.aws_lb.my_alb.tags["Name"]
  alb_arn_suffix          = data.aws_lb.my_alb.arn_suffix
  target_group_arn_suffix = data.aws_lb_target_group.my_alb_tg.arn_suffix
  notify_arns             = [local.sns_topic]
}
