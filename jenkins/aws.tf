variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_name" {}

# Configure the AWS Provider
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "eu-west-1"
}

resource "aws_security_group" "allow_http" {
  name = "allow_http"
  description = "Allow port 80 "

  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins" {
    ami = "ami-47a23a30"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    security_groups = ["default", "allow_http"]

    connection {
        user = "ubuntu"
        key_file = "${var.aws_key_name}.pem"
    }

    provisioner "file" {
       source = "../cookbooks-jenkins-simple-app/berks-cookbooks"
       destination = "/home/ubuntu/cookbooks"
    }

    provisioner "file" {
       source = "config.rb"
       destination = "/home/ubuntu/config.rb"
    }

    provisioner "file" {
       source = "jenkins.json"
       destination = "/home/ubuntu/jenkins.json"
    }

    provisioner "remote-exec" {
        inline = [
          "curl -L https://www.opscode.com/chef/install.sh | sudo bash",
          "sudo chef-solo -c config.rb -j jenkins.json"
        ]
    }
}
