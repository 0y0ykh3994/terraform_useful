locals {
  aws_region      = "${yamldecode(file("./common.yaml"))["aws_region"]}"
  account_id      = "${yamldecode(file("./common.yaml"))["aws_account_id"]}"
  aws_access_key  = "${yamldecode(file("./common.yaml"))["aws_access_key"]}"
  aws_secret_key  = "${yamldecode(file("./common.yaml"))["aws_secret_key"]}"
}

provider "aws" {
  region      = "${local.aws_region}"
  access_key  = "${local.aws_access_key}"
  secret_key  = "${local.aws_secret_key}"
}

module "vpc" {
  source = "./ap-northeast-2/vpc/"
}

terraform {
  backend "s3" {
    bucket = "mys3-terraform-state"
    key    = "terraform.tfstate/"
    region = "ap-northeast-2"
  }
}
