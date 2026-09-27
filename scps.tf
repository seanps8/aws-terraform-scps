terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "raft-scp-terraform-state"
    key    = "state/scps.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region              = "us-east-1"
#   profile             = "personal-aws"
}

module "tag_and_scp_policy" {
  source = "./src/modules/scps"

  policy_name     = "require-tags"
  root_target_id  = "r-rsvw"  # e.g., Organizational Unit or Account ID
  member_target_id = "1234567890"
  policy_path     = "${path.module}/src/modules/scps/external/scp_minified_1.json"
  tag_policy_path = "${path.module}/src/modules/scps/external/tag_policy.json" 
}