module "svn_codebuild" {
  source = "./lib/codebuild"

  codebuild_name = "${var.codebuild_name}"
  vpc_id = "${var.vpc_id}"
  subnets = "${var.subnets}"
  security_group_ids = "${var.security_group_ids}"
  code_source = "${var.codebuild_source}"
  s3_bucket_name = "${var.codebuild_s3_bucket_name}"
  artifacts_type = "${var.artifacts_type}"
}
