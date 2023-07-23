# Information

Simplified variant of [cloudposse/terraform-aws-alb-target-group-cloudwatch-sns-alarms](https://github.com/cloudposse/terraform-aws-alb-target-group-cloudwatch-sns-alarms) module with small additions:

- changed **alarm_name** argument to a more simple variant where you can prefix alarm name with value from `var.name_prefix`
- removed **count** conditionals from resources implying that we're using this module to actually create resources
- slightly changed default threshold/alarm values/alarm_descriptions
- removed insufficient_data actions
- added `var.tags` map

For a complete example, see the `example/` folder.

```hcl
locals {
  region       = "us-east-2"
  alb_name = "my_alb_name" # should already exist
  tg_name  = "my_alb_target_group_name" # should already exist
}

provider "aws" {
  region  = local.region
}

data "aws_lb" "my_alb" {
  name = local.alb_name
}

data "aws_lb_target_group" "my_alb_tg" {
  name = local.tg_name
}

module "sns" {
  source = "terraform-aws-modules/sns/aws"
  name   = "default"
}

module "alb_alarms" {
  source = "slitsevych/alb-target-group-cloudwatch-sns-alarms/aws"

  name_prefix             = data.aws_lb.my_alb.tags["Name"]
  alb_arn_suffix          = data.aws_lb.my_alb.arn_suffix
  target_group_arn_suffix = data.aws_lb_target_group.my_alb_tg.arn_suffix
  notify_arns             = [module.sns.topic_arn]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.httpcode_elb_5xx_count](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.httpcode_target_3xx_count](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.httpcode_target_4xx_count](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.httpcode_target_5xx_count](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.target_response_time_average](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_actions"></a> [alarm\_actions](#input\_alarm\_actions) | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an ALARM state from any other state.  If set, this list takes precedence over notify\_arns | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_alb_arn_suffix"></a> [alb\_arn\_suffix](#input\_alb\_arn\_suffix) | The ARN suffix of ALB | `string` | n/a | yes |
| <a name="input_elb_5xx_count_threshold"></a> [elb\_5xx\_count\_threshold](#input\_elb\_5xx\_count\_threshold) | The maximum count of ELB 5XX requests over a period. A negative value will disable the alert | `number` | `50` | no |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | Number of periods to evaluate for the alarm | `number` | `2` | no |
| <a name="input_httpcode_alarm_description"></a> [httpcode\_alarm\_description](#input\_httpcode\_alarm\_description) | The string to format and use as the httpcode alarm description | `string` | `"HTTPCode %v error count is too hight for over %v last %d minute(s) over %v period(s)"` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name prefix for alarm names | `string` | `""` | no |
| <a name="input_notify_arns"></a> [notify\_arns](#input\_notify\_arns) | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into ANY state from any other state. May be overridden by the value of a more specific {alarm,ok,insufficient\_data}\_actions variable. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_ok_actions"></a> [ok\_actions](#input\_ok\_actions) | A list of ARNs (i.e. SNS Topic ARN) to execute when this alarm transitions into an OK state from any other state. If set, this list takes precedence over notify\_arns | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_period"></a> [period](#input\_period) | Duration in seconds to evaluate for the alarm | `number` | `300` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(any)` | `{}` | no |
| <a name="input_target_3xx_count_threshold"></a> [target\_3xx\_count\_threshold](#input\_target\_3xx\_count\_threshold) | The maximum count of 3XX requests over a period. A negative value will disable the alert | `number` | `50` | no |
| <a name="input_target_4xx_count_threshold"></a> [target\_4xx\_count\_threshold](#input\_target\_4xx\_count\_threshold) | The maximum count of 4XX requests over a period. A negative value will disable the alert | `number` | `50` | no |
| <a name="input_target_5xx_count_threshold"></a> [target\_5xx\_count\_threshold](#input\_target\_5xx\_count\_threshold) | The maximum count of 5XX requests over a period. A negative value will disable the alert | `number` | `50` | no |
| <a name="input_target_group_arn_suffix"></a> [target\_group\_arn\_suffix](#input\_target\_group\_arn\_suffix) | The ARN suffix of ALB Target Group | `string` | n/a | yes |
| <a name="input_target_response_time_alarm_description"></a> [target\_response\_time\_alarm\_description](#input\_target\_response\_time\_alarm\_description) | The string to format and use as the target response time alarm description | `string` | `"Average target response time average is too high for over %v last %d minute(s) over %v period(s)"` | no |
| <a name="input_target_response_time_threshold"></a> [target\_response\_time\_threshold](#input\_target\_response\_time\_threshold) | The maximum average target response time (in seconds) over a period. A negative value will disable the alert | `number` | `3` | no |
| <a name="input_treat_missing_data"></a> [treat\_missing\_data](#input\_treat\_missing\_data) | Sets how alarms handle missing data points. Values supported: missing, ignore, breaching and notBreaching | `string` | `"missing"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_alarms_list"></a> [alb\_alarms\_list](#output\_alb\_alarms\_list) | The list of all alarms |
| <a name="output_httpcode_elb_5xx_count_cloudwatch_metric_alarm_arn"></a> [httpcode\_elb\_5xx\_count\_cloudwatch\_metric\_alarm\_arn](#output\_httpcode\_elb\_5xx\_count\_cloudwatch\_metric\_alarm\_arn) | ELB 5xx count CloudWatch metric alarm ARN |
| <a name="output_httpcode_elb_5xx_count_cloudwatch_metric_alarm_id"></a> [httpcode\_elb\_5xx\_count\_cloudwatch\_metric\_alarm\_id](#output\_httpcode\_elb\_5xx\_count\_cloudwatch\_metric\_alarm\_id) | ELB 5xx count CloudWatch metric alarm ID |
| <a name="output_httpcode_target_3xx_count_cloudwatch_metric_alarm_arn"></a> [httpcode\_target\_3xx\_count\_cloudwatch\_metric\_alarm\_arn](#output\_httpcode\_target\_3xx\_count\_cloudwatch\_metric\_alarm\_arn) | Target Group 3xx count CloudWatch metric alarm ARN |
| <a name="output_httpcode_target_3xx_count_cloudwatch_metric_alarm_id"></a> [httpcode\_target\_3xx\_count\_cloudwatch\_metric\_alarm\_id](#output\_httpcode\_target\_3xx\_count\_cloudwatch\_metric\_alarm\_id) | Target Group 3xx count CloudWatch metric alarm ID |
| <a name="output_httpcode_target_4xx_count_cloudwatch_metric_alarm_arn"></a> [httpcode\_target\_4xx\_count\_cloudwatch\_metric\_alarm\_arn](#output\_httpcode\_target\_4xx\_count\_cloudwatch\_metric\_alarm\_arn) | Target Group 4xx count CloudWatch metric alarm ARN |
| <a name="output_httpcode_target_4xx_count_cloudwatch_metric_alarm_id"></a> [httpcode\_target\_4xx\_count\_cloudwatch\_metric\_alarm\_id](#output\_httpcode\_target\_4xx\_count\_cloudwatch\_metric\_alarm\_id) | Target Group 4xx count CloudWatch metric alarm ID |
| <a name="output_httpcode_target_5xx_count_cloudwatch_metric_alarm_arn"></a> [httpcode\_target\_5xx\_count\_cloudwatch\_metric\_alarm\_arn](#output\_httpcode\_target\_5xx\_count\_cloudwatch\_metric\_alarm\_arn) | Target Group 5xx count CloudWatch metric alarm ARN |
| <a name="output_httpcode_target_5xx_count_cloudwatch_metric_alarm_id"></a> [httpcode\_target\_5xx\_count\_cloudwatch\_metric\_alarm\_id](#output\_httpcode\_target\_5xx\_count\_cloudwatch\_metric\_alarm\_id) | Target Group 5xx count CloudWatch metric alarm ID |
| <a name="output_target_response_time_average_cloudwatch_metric_alarm_arn"></a> [target\_response\_time\_average\_cloudwatch\_metric\_alarm\_arn](#output\_target\_response\_time\_average\_cloudwatch\_metric\_alarm\_arn) | Target Group response time average CloudWatch metric alarm ARN |
| <a name="output_target_response_time_average_cloudwatch_metric_alarm_id"></a> [target\_response\_time\_average\_cloudwatch\_metric\_alarm\_id](#output\_target\_response\_time\_average\_cloudwatch\_metric\_alarm\_id) | Target Group response time average CloudWatch metric alarm ID |
<!-- END_TF_DOCS -->