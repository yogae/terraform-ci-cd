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