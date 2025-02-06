resource "aws_route53_record" "expense" {
    count           = length(var.instance_names)
    zone_id         = local.zone_id
    #backend.advik.fun
    name            = var.instance_names[count.index] == "frontend" ? local.domain_name : "${var.instance_names[count.index]}.${local.domain_name}"
    type            = "A"
    ttl             = 1
    records         = var.instance_names[count.index] == "frontend" ? [aws_instance.terraform[count.index].public_ip] : [aws_instance.terraform[count.index].private_ip]
    #if frontend, then public ip, if not, then private ip
    allow_overwrite = true
}