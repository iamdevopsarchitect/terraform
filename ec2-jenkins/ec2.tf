resource "aws_instance" "jenkins-master" {
    
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

resource "aws_instance" "jenkins-agent" {
    
    ami = "ami-09c813fb71547fc4f" # left side and right side need not to be same
    instance_type =  "t3.small" 
    vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
    tags = {
        Name = "agent"
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
            "sudo yum install java-17-openjdk -y",
            "sudo dnf module disable nodejs -y",
            "sudo dnf module enable nodejs:20 -y",
            "sudo dnf install nodejs -y",
            "sudo dnf -y install dnf-plugins-core",
            "sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo",
            "sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y",
            "sudo usermod -aG docker ec2-user",
            "sudo systemctl start docker"
            

        ]
    }
    provisioner "remote-exec" {
        when = destroy
        inline = [
            "echo shutting down server",
            "sudo systemctl stop docker"
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
        protocol            = "-1"
        cidr_blocks         = ["0.0.0.0/0"] # allow from evreyone
        ipv6_cidr_blocks    = ["::/0"]
    }

    tags = {
        Name = "allow_sshh"
    }
}