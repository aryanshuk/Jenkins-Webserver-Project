terraform {
  required_providers {
    myawscloud = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "myawscloud" {
        region = var.AWS_REGION
}

resource "aws_instance" "Web" {
	ami = var.amiID
        key_name = "terraform-aws-key"
        vpc_security_group_ids = ["sg-00b963cf889d9f920"]
        instance_type = "t2.micro"
        tags = {
                Name=var.osname
        }
}

resource "null_resource" "saveIP" {

  provisioner "local-exec" {
    command = "echo ${aws_instance.Web.public_ip} > public_ip"
  }
}
