locals {
  # default to using notify_arns unless a more specific action is specified.
  alarm_actions = compact(coalescelist(var.alarm_actions, var.notify_arns))
  ok_actions    = compact(coalescelist(var.ok_actions, var.notify_arns))

  thresholds = {
    target_3xx_count     = max(var.target_3xx_count_threshold, 0)
    target_4xx_count     = max(var.target_4xx_count_threshold, 0)
    target_5xx_count     = max(var.target_5xx_count_threshold, 0)
    elb_5xx_count        = max(var.elb_5xx_count_threshold, 0)
    target_response_time = max(var.target_response_time_threshold, 0)
  }

  target_group_dimensions_map = {
    "TargetGroup"  = var.target_group_arn_suffix
    "LoadBalancer" = var.alb_arn_suffix
  }

  load_balancer_dimensions_map = {
    "LoadBalancer" = var.alb_arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_3xx_count" {
  alarm_name          = "${var.name_prefix}-HTTPCode_Target_3xx_count"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "HTTPCode_Target_3XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = var.period
  statistic           = "Sum"
  threshold           = local.thresholds["target_3xx_count"]
  treat_missing_data  = var.treat_missing_data
  alarm_description   = format(var.httpcode_alarm_description, "3XX", local.thresholds["target_3xx_count"], var.period / 60, var.evaluation_periods)
  alarm_actions       = local.alarm_actions
  ok_actions          = local.ok_actions
  dimensions          = local.target_group_dimensions_map
  tags                = var.tags
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_4xx_count" {
  alarm_name          = "${var.name_prefix}-HTTPCode_Target_4xx_count"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "HTTPCode_Target_4XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = var.period
  statistic           = "Sum"
  threshold           = local.thresholds["target_4xx_count"]
  treat_missing_data  = var.treat_missing_data
  alarm_description   = format(var.httpcode_alarm_description, "4XX", local.thresholds["target_4xx_count"], var.period / 60, var.evaluation_periods)
  alarm_actions       = local.alarm_actions
  ok_actions          = local.ok_actions
  dimensions          = local.target_group_dimensions_map
  tags                = var.tags
}

resource "aws_cloudwatch_metric_alarm" "httpcode_target_5xx_count" {
  alarm_name          = "${var.name_prefix}-HTTPCode_Target_5xx_count"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = var.period
  statistic           = "Sum"
  threshold           = local.thresholds["target_5xx_count"]
  treat_missing_data  = var.treat_missing_data
  alarm_description   = format(var.httpcode_alarm_description, "5XX", local.thresholds["target_5xx_count"], var.period / 60, var.evaluation_periods)
  alarm_actions       = local.alarm_actions
  ok_actions          = local.ok_actions
  dimensions          = local.target_group_dimensions_map
  tags                = var.tags
}

resource "aws_cloudwatch_metric_alarm" "httpcode_elb_5xx_count" {
  alarm_name          = "${var.name_prefix}-HTTPCode_ELB_5xx_count"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = var.period
  statistic           = "Sum"
  threshold           = local.thresholds["elb_5xx_count"]
  treat_missing_data  = var.treat_missing_data
  alarm_description   = format(var.httpcode_alarm_description, "ELB-5XX", local.thresholds["elb_5xx_count"], var.period / 60, var.evaluation_periods)
  alarm_actions       = local.alarm_actions
  ok_actions          = local.ok_actions
  dimensions          = local.load_balancer_dimensions_map
  tags                = var.tags
}

resource "aws_cloudwatch_metric_alarm" "target_response_time_average" {
  alarm_name          = "${var.name_prefix}-Average_Target_Response_Time"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "TargetResponseTime"
  namespace           = "AWS/ApplicationELB"
  period              = var.period
  statistic           = "Average"
  threshold           = local.thresholds["target_response_time"]
  treat_missing_data  = var.treat_missing_data
  alarm_description   = format(var.target_response_time_alarm_description, local.thresholds["target_response_time"], var.period / 60, var.evaluation_periods)
  alarm_actions       = local.alarm_actions
  ok_actions          = local.ok_actions
  dimensions          = local.target_group_dimensions_map
  tags                = var.tags
}
