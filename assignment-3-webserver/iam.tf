resource "aws_iam_role" "ec2_s3_read" {
    name = "tf-ec2-s3-read-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
}

resource "aws_iam_policy" "s3_readonly" {
    name = "tf-s3-readonly-policy"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = ["s3:GetObject","s3:ListBucket"]
                Resource = "arn:aws:s3:::*"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "attach" {
    role = aws_iam_role.ec2_s3_read.name
    policy_arn = aws_iam_policy.s3_readonly.arn
}

resource "aws_iam_instance_profile" "ec2_s3_read" {
    name = "tf-ec2-s3-read-profile"
    role = aws_iam_role.ec2_s3_read.name
}