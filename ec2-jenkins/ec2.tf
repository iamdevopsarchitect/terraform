resource "aws_instance" "jenkins" {
    
    ami = "ami-09c813fb71547fc4f" # left side and right side need not to be same
    instance_type =  "t3.small" 
    vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
    tags = {
        Name = "master"
    }
    connection {
        type    = "ssh"
        user    = "ec2-user"
        password = "DevOps321"
        host    = self.public_ip
    }
    # provisioners will execute at the time of creation of rsources
    provisioner "remote-exec" {
        inline = [
            "sudo curl -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
            "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key",
            "sudo yum install fontconfig java-17-openjdk -y",
            "sudo yum install jenkins -y",
            "sudo systemctl start jenkins",
            "sudo systemctl enable jenkins"
        ]
    }
    provisioner "remote-exec" {
        when = destroy
        inline = [
            "sudo systemctl stop jenkins"
        ]
    }    
}

resource "aws_security_group" "allow_ssh_terraform" {
    name        = "allow_sshh" # allow_ssh is already there in my account
    description = "Allow port number 22 for SSH access"

    # usually we allow everything in egress
    egress {
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_blocks         = ["0.0.0.0/0"]
        ipv6_cidr_blocks    = ["::/0"]  
    }

    ingress {
        from_port           = 0
        to_port             = 0
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"] # allow from evreyone
        ipv6_cidr_blocks    = ["::/0"]
    }

    tags = {
        Name = "allow_sshh"
    }
}