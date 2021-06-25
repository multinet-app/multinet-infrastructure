terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "multinet"

    workspaces {
      name = "multinet-prod"
    }
  }
}

// This is the "project" account, the primary account with most resources
provider "aws" {
  region              = "us-east-2"
  allowed_account_ids = ["842483300902"]
  # Must set AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY envvars
}

#provider "heroku" {
  # Must set HEROKU_EMAIL, HEROKU_API_KEY envvars
#}

data "aws_caller_identity" "project_account" {}
