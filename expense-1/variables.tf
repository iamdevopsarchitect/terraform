variable "instance_names" {
  type        = list(string)
  default     = ["mysql", "backend", "frontend"]
  description = "description"
}

variable "domain_name" {
  default = "advik.fun"
}

variable "zone_id" {
  default = "Z054232429ON8YKDFVZS8"
}