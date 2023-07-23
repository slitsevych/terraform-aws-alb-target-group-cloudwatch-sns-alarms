output "httpcode_target_3xx_count_cloudwatch_metric_alarm_id" {
  value       = aws_cloudwatch_metric_alarm.httpcode_target_3xx_count.id
  description = "Target Group 3xx count CloudWatch metric alarm ID"
}

output "httpcode_target_3xx_count_cloudwatch_metric_alarm_arn" {
  value       = aws_cloudwatch_metric_alarm.httpcode_target_3xx_count.arn
  description = "Target Group 3xx count CloudWatch metric alarm ARN"
}

output "httpcode_target_4xx_count_cloudwatch_metric_alarm_id" {
  value       = aws_cloudwatch_metric_alarm.httpcode_target_4xx_count.id
  description = "Target Group 4xx count CloudWatch metric alarm ID"
}

output "httpcode_target_4xx_count_cloudwatch_metric_alarm_arn" {
  value       = aws_cloudwatch_metric_alarm.httpcode_target_4xx_count.arn
  description = "Target Group 4xx count CloudWatch metric alarm ARN"
}

output "httpcode_target_5xx_count_cloudwatch_metric_alarm_id" {
  value       = aws_cloudwatch_metric_alarm.httpcode_target_5xx_count.id
  description = "Target Group 5xx count CloudWatch metric alarm ID"
}

output "httpcode_target_5xx_count_cloudwatch_metric_alarm_arn" {
  value       = aws_cloudwatch_metric_alarm.httpcode_target_5xx_count.arn
  description = "Target Group 5xx count CloudWatch metric alarm ARN"
}

output "httpcode_elb_5xx_count_cloudwatch_metric_alarm_id" {
  value       = aws_cloudwatch_metric_alarm.httpcode_elb_5xx_count.id
  description = "ELB 5xx count CloudWatch metric alarm ID"
}

output "httpcode_elb_5xx_count_cloudwatch_metric_alarm_arn" {
  value       = aws_cloudwatch_metric_alarm.httpcode_elb_5xx_count.arn
  description = "ELB 5xx count CloudWatch metric alarm ARN"
}

output "target_response_time_average_cloudwatch_metric_alarm_id" {
  value       = aws_cloudwatch_metric_alarm.target_response_time_average.id
  description = "Target Group response time average CloudWatch metric alarm ID"
}

output "target_response_time_average_cloudwatch_metric_alarm_arn" {
  value       = aws_cloudwatch_metric_alarm.target_response_time_average.arn
  description = "Target Group response time average CloudWatch metric alarm ARN"
}

output "alb_alarms_list" {
  description = "The list of all alarms"
  value = [
    [aws_cloudwatch_metric_alarm.target_response_time_average.arn],
    [aws_cloudwatch_metric_alarm.httpcode_elb_5xx_count.arn],
    [aws_cloudwatch_metric_alarm.httpcode_target_5xx_count.arn],
    [aws_cloudwatch_metric_alarm.httpcode_target_4xx_count.arn],
    [aws_cloudwatch_metric_alarm.httpcode_target_3xx_count.arn]
  ]
}