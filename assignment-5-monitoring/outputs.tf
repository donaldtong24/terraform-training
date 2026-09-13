output "cw_alarm_name" {
    value = aws_cloudwatch_metric_alarm.cpu_high.alarm_name
}

output "lambda_function_name" {
    value = aws_lambda_function.cpu_alarm_logger.function_name
}