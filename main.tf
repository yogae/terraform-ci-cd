module "svn_codebuild" {
  source = "./lib/codebuild"

  vpc_id = "${var.vpc_id}"
  subnets = "${var.subnets}"
  security_group_ids = "${var.security_group_ids}"
  code_source = "${var.codebuild_source}"
  s3_bucket_name = "${var.codebuild_s3_bucket_name}"
}
