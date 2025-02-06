# 1. command line
# 2. terraform.tfvars
# 3. environment variables, TF_VAR_Your_variable_name
# 4. default
# 5. prompt, if we didnt give in all above places, tf will ask while executing

variable "ami_id" {
    type        = string
    default     = "ami-09c813fb71547fc4f"
    description = "This is the AMI ID of devops-practice which is RHEL-9"
}

variable "instance_type" {
    type    = string
    default = "t3.micro"
}
variable "tags" {
    type = map #optional
    default = {
        Name = "backend"
        Project = "expense"
        Component = "backend"
        Environment = "DEV"
        Terraform = "true"
    }
}

variable "sg_name" {
    default = "allow_sshh" # allow_ssh is already there inmy acount
}

variable "sg_description" {
    default = "Allow port nmumber 22 for ssh access"
}

variable "from_port" {
    default = 22
    type = number
}

variable "to_port" {
    default = 22
    type = number
}

variable "protcol" {
    default = "tcp"
}

variable "ingress_cidr" {
    type = list(string)
    default = ["0.0.0.0/0"]
}