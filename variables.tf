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
    default = ""
}

variable "allowed_account_ids" {
    type = list(string)
    default = ""
}

variable "aws_access_key" {
    type = string
    default = ""
}

variable "aws_secret_key" {
    type = string
    default = ""
}

variable "artifacts_type" {
    type = string
    default = "NO_ARTIFACTS"
}