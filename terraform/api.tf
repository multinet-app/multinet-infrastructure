data "heroku_team" "multinet" {
  name = "kitware"
}

module "api" {
  source  = "girder/django/heroku"
  version = "0.9.0"

  django_default_from_email = "no-reply@multinet.app"
  heroku_app_name = "multinet"
  team_name = data.heroku_team.multinet.name
  project_slug = "multinet-api"

  # TODO
  route53_zone_id  = aws_route53_zone.multinet.zone_id

  subdomain_name   = "api"

  #heroku_web_dyno_size    = "standard-1x"
  #heroku_worker_dyno_size = "standard-2x"
  #heroku_postgresql_plan  = "standard-0"
  #heroku_cloudamqp_plan   = "squirrel-1"
  #heroku_papertrail_plan  = "forsta"

  django_cors_origin_whitelist = ["https://multinet.app"]
  django_cors_origin_regex_whitelist = ["^https:\\/\\/[0-9a-z\\-]+--multinet-app\\.netlify\\.app$"]

  #additional_django_vars = {
    #DJANGO_SENTRY_DSN = ""
  #}
}

data "aws_iam_user" "api" {
  user_name = module.api.heroku_iam_user_id
}

resource "aws_s3_bucket" "upload_bucket" {
  bucket = "multinet-api-upload"
  acl    = "private"
}

resource "aws_iam_user_policy" "upload_bucket" {
  name = "mutlinet-api-bucket"
  user = data.aws_iam_user.api.user_name
  policy = data.aws_iam_policy_document.multinet_bucket.json
}

data "aws_iam_policy_document" "multinet_bucket" {
  statement {
    actions = [
      # TODO Figure out minimal set of permissions django storages needs for S3
      "s3:*",
    ]
    resources = [
      aws_s3_bucket.upload_bucket.arn,
      "${aws_s3_bucket.upload_bucket.arn}/*",
    ]
  }
}

#resource "aws_iam_role" "write_public_dataset" {
  #name               = "write-public-dataset"
  #description        = "Allows EC2 instances to call AWS services on your behalf."
  #assume_role_policy = data.aws_iam_policy_document.write_public_dataset.json
  #inline_policy {
    #name   = "write-public-dataset"
    #policy = data.aws_iam_policy_document.write_public_dataset_inline.json
  #}
  #managed_policy_arns = [
    #"arn:aws:iam::aws:policy/AmazonS3FullAccess",
  #]
#}

#data "aws_iam_policy_document" "write_public_dataset" {
  #version = "2012-10-17"
  #statement {
    #actions = ["sts:AssumeRole"]
    #principals {
      #type        = "Service"
      #identifiers = ["ec2.amazonaws.com"]
    #}
  #}
#}

#data "aws_iam_policy_document" "write_public_dataset_inline" {
  #version = "2012-10-17"
  #statement {
    #actions   = ["sts:AssumeRole"]
    #effect    = "Allow"
    #resources = [aws_iam_role.sponsored_dandi_writer.arn]
  #}
#}


#resource "aws_iam_role" "dandi_girder" {
  #name               = "dandi-girder"
  #assume_role_policy = data.aws_iam_policy_document.dandi_girder.json
  #inline_policy {
    #name   = "write-public-dataset"
    #policy = data.aws_iam_policy_document.write_public_dataset_inline.json
  #}
  #managed_policy_arns = [
    #"arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    #"arn:aws:iam::aws:policy/AmazonS3FullAccess",
  #]
#}

#data "aws_iam_policy_document" "dandi_girder" {
  #version = "2012-10-17"
  #statement {
    #actions = ["sts:AssumeRole"]
    #principals {
      #type        = "Service"
      #identifiers = ["ec2.amazonaws.com"]
    #}
  #}
#}
