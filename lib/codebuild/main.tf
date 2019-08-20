resource "aws_iam_role" "svn_codebuild_role" {
  name = "svn_codebuild_role"

  assume_role_policy = <<EOF
{

  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "svn_codebuild_role_policy" {
  role = "${aws_iam_role.svn_codebuild_role.name}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::${var.s3_bucket_name}",
        "arn:aws:s3:::${var.s3_bucket_name}/*"
      ]
    }
  ]
}
POLICY
}

locals {
  codebuild_artifacts_def = {
    CODEPIPELINE = {
      type = "CODEPIPELINE"
    }
    NO_ARTIFACTS = {
      type = "NO_ARTIFACTS"
    }
  }
  
  codebuild_artifacts = "${local.codebuild_artifacts_def[var.artifacts_type]}"
}

resource "aws_codebuild_project" "svn_codebuild" {
  name          = "${var.codebuild_name}"
  description   = "svn codebuild"
  build_timeout = "10"
  service_role  = "${aws_iam_role.svn_codebuild_role.arn}"

  artifacts {
    type = "${local.codebuild_artifacts.type}"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type            = "${var.code_source["type"]}"
    location        = "${var.s3_bucket_name}/${var.code_source["location"]}"
  }

  tags = {
    Environment = "Test"
  }
}