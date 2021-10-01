resource "aws_s3_bucket" "bucket" {
    bucket = var.name
    acl = "public-read"
    force_destroy = true

    tags = merge(
      var.tags,
      {
          "hc-internet-facing" = true
      }
    )
}

resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = aws_s3_bucket.bucket.id

    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "PublicBucketPolicy",
  "Statement": [
    {
      "Sid": "PublicReadForGetBucketObjects",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["s3:GetObject"],
      "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"
    }
  ]
}
POLICY
}