output "s3_bucket_names" {
    value = aws_s3_bucket.app_data[*].bucket
}

output "ebs_volume_id" {
    value = aws_ebs_volume.extra.id
}