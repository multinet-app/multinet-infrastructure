resource "aws_route53_zone" "multinet" {
  name = "multinet.app"
}

# AWS DB
resource "aws_route53_record" "db" {
  zone_id = aws_route53_zone.multinet.zone_id
  name    = "db.multinet.app"
  type    = "CNAME"
  ttl     = "300"
  records = ["ec2-3-14-123-189.us-east-2.compute.amazonaws.com"]
}

# Heroku API managed by api.tf

# Netlify clients, all point to the netlify load balancer
resource "aws_route53_record" "client-apex" {
  zone_id = aws_route53_zone.multinet.zone_id
  name    = "multinet.app"
  type    = "A"
  ttl     = "300"
  records = ["75.2.60.5"]
}
resource "aws_route53_record" "client-www" {
  zone_id = aws_route53_zone.multinet.zone_id
  name    = "www.multinet.app"
  type    = "A"
  ttl     = "300"
  records = ["75.2.60.5"]
}
resource "aws_route53_record" "multimatrix" {
  zone_id = aws_route53_zone.multinet.zone_id
  name    = "multimatrix.multinet.app"
  type    = "A"
  ttl     = "300"
  records = ["75.2.60.5"]
}
resource "aws_route53_record" "multilink" {
  zone_id = aws_route53_zone.multinet.zone_id
  name    = "multilink.multinet.app"
  type    = "A"
  ttl     = "300"
  records = ["75.2.60.5"]
}

resource "aws_route53_record" "multidynamic" {
  zone_id = aws_route53_zone.multinet.zone_id
  name    = "multidynamic.multinet.app"
  type    = "A"
  ttl     = "300"
  records = ["75.2.60.5"]
}


resource "aws_route53_record" "upset" {
  zone_id = aws_route53_zone.multinet.zone_id
  name    = "upset.multinet.app"
  type    = "A"
  ttl     = "300"
  records = ["75.2.60.5"]
}

# Docs
resource "aws_route53_record" "docs" {
  zone_id = aws_route53_zone.multinet.zone_id
  name    = "docs.multinet.app"
  type    = "CNAME"
  ttl     = "300"
  records = ["multinet-app.readthedocs.io"]
}
