resource "aws_route53_zone" "multinet" {
  name = "next.multinet.app"
}

# Record for client Netlify deployment
resource "aws_route53_record" "next-client" {
  zone_id = aws_route53_zone.multinet.zone_id
  name    = "web.next.multinet.app"
  type    = "CNAME"
  ttl     = "300"
  records = ["multinet-next.netlify.app"]
}
