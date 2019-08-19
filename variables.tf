variable "vpc_id" {
    type = string
}

variable "subnets" {
    type = list(string)
}

variable "security_group_ids" {
    type = list(string)
}

variable "codebuild_source" {
    type = map
}

variable "codebuild_s3_bucket_name" {
    type = string
}

variable "forbidden_account_ids" {
    type = list(string)
}

variable "allowed_account_ids" {
    type = list(string)
}

variable "aws_access_key" {
    type = string
}

variable "aws_secret_key" {
    type = string
}

variable "artifacts_type" {
    type = string
    default = "NO_ARTIFACTS"
}