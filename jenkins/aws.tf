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

    provisioner "chef" {
       attributes {
            "chef_client" {
                "interval" = 60
            }
            "jenkins_simple_app" {
                "git_repository_url" = "http://github.com/CatCalZone/jenkins-jobs.git"
            }
       }
       environment = "_default"
       run_list = ["chef-client", "jenkins-simple-app"]
       node_name = "pascal2"
       server_url = "https://api.opscode.com/organizations/zuehlkeccz"
       validation_client_name = "zuehlkeccz-validator"
       validation_key_path = "zuehlkeccz-validator.pem"
       version = "12.3.0"
    }
}
