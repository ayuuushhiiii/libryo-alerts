provider "aws" {
  region = "us-east-1"
}
module "sns" {
  source     = "./modules/sns"
  topic_name = "lambda-log-alerts"
  email      = var.alert_email
}

module "log_filters" {
  source = "./modules/log-metric-filter"

  for_each = toset(var.lambda_names)

  lambda_name      = each.key
  filter_pattern   = "\"[ERROR]\" OR \"Exception\" OR \"INIT_REPORT\" OR \"Task timed out\""
  metric_name      = "ErrorCount"
  metric_namespace = "Lambda/LogMonitoring"
}

module "alarms" {
  source = "./modules/alarm"

  for_each = toset(var.lambda_names)

  alarm_name       = "${each.key}-error-alarm"
  metric_name      = module.log_filters[each.key].metric_name
  metric_namespace = module.log_filters[each.key].metric_namespace
  sns_topic_arn    = module.sns.topic_arn
}
