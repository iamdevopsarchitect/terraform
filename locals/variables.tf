variable "instance_names" {
    type = list(string)
    default = ["mysql", "backend", "frontend"]
}


# variable "zone_id" {
#     default = "Z054232429ON8YKDFVZS8"
# }

# variable "domain_name" {
#     default = "advik.fun"
# }
variable "environment" {
    default = "prod"
    
}