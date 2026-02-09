resource "aws_cloudwatch_log_metric_filter" "this" {
  name           = "${var.lambda_name}-log-filter"
  log_group_name = "/aws/lambda/${var.lambda_name}"

  pattern = var.filter_pattern

  metric_transformation {
    name      = var.metric_name
    namespace = var.metric_namespace
    value     = "1"
  }
}
