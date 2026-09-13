# Execution role

resource "aws_iam_role" "lambda_exec" {
    name = "tf-lambda-basic-execution-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "lambda.amazonaws.com"
                }
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
    role = aws_iam_role.lambda_exec.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#packaging the code
data "archive_file" "lambda_zip" {
    type = "zip"
    source_file = "${path.module}/lambda_function.py"
    output_path = "${path.module}/lambda_payload.zip"
    
}

#lambda function
resource "aws_lambda_function" "cpu_alarm_logger" {
    function_name = "tf-cpu-alarm-logger"
    role = aws_iam_role.lambda_exec.arn
    handler = "lambda_function.lambda_handler"
    runtime = "python3.9"
    filename = data.archive_file.lambda_zip.output_path
    source_code_hash = data.archive_file.lambda_zip.output_base64sha256 #used to detect code changes
    memory_size = 128
    timeout = 30

    environment {
        variables = {
            INSTANCE_ID = data.aws_instance.web.id
        }
    }
}

#allow cloudwatch to invoke the lambda
resource "aws_lambda_permission" "allow_cloudwatch" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.cpu_alarm_logger.function_name
    principal = "lambda.alarms.cloudwatch.amazonaws.com" #used this instead of the assignment doc suggestion
    source_arn = aws_cloudwatch_metric_alarm.cpu_high.arn
}