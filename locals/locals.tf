locals {
    domain_name = "advik.fun"
    zone_id = "Z054232429ON8YKDFVZS8"
    instance_type = var.environment == "prod" ? "t3.medium" : "t3.micro"
    #count.index will not work in locals
}