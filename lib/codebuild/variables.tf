variable "vpc_id" {
    type = string
}

variable "subnets" {
    type = list(string)
}

variable "security_group_ids" {
    type = list(string)
}

variable "code_source" {
    type = map
}

variable "s3_bucket_name" {
    type = string
}

variable "artifacts_type" {
    type = string
    default = "NO_ARTIFACTS"
}

variable "codebuild_name" {
    type = string
}
