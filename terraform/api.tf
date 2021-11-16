data "heroku_team" "visualizationdesignlab" {
  name = "visualizationdesignlab"
}

module "api" {
  source  = "girder/django/heroku"
  version = "0.9.0"

  django_default_from_email = "no-reply@multinet.app"
  heroku_app_name = "next-multinet"
  heroku_team_name = data.heroku_team.visualizationdesignlab.name
  project_slug = "next-multinet-api"

  route53_zone_id  = aws_route53_zone.multinet.zone_id
  subdomain_name   = "api"

  django_cors_origin_whitelist = ["https://multinet.app", "https://multimatrix.multinet.app", "https://multilink.multinet.app", "https://vdl.sci.utah.edu/Trevo/"]
  django_cors_origin_regex_whitelist = ["^https:\\/\\/deploy-preview-[0-9a-z\\-]+--next-multinet-client\\.netlify\\.app$", "^https:\\/\\/deploy-preview-[0-9a-z\\-]+--next-multimatrix\\.netlify\\.app$", "^https:\\/\\/deploy-preview-[0-9a-z\\-]+--next-multilink\\.netlify\\.app$"]
  

  additional_sensitive_django_vars = {
    DJANGO_MULTINET_ARANGO_PASSWORD = var.MULTINET_ARANGO_PASSWORD
    DJANGO_MULTINET_ARANGO_READONLY_PASSWORD = var.MULTINET_ARANGO_READONLY_PASSWORD
  }
}
