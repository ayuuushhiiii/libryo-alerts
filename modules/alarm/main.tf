resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = var.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = 1
  period              = 300
  statistic           = "Sum"

  metric_name = var.metric_name
  namespace   = var.metric_namespace

  alarm_actions = [var.sns_topic_arn]
}
