# use output.instances_info
# output.instances_info == aws_instance.expense
# output "instances_info" {
#     value = aws_instance.expense
# }

output "public_ip" {
    value       = aws_instance.terraform.public_ip
    sensitive   = false
    description = "Thi is the Public IP of instance created"    
}