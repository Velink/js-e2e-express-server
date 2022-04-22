packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "learn-packer-linux-aws"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file = "/Users/velinkalenderski/Downloads/vsts-agent-osx-x64-2.202.0/_work/4/s/install_nginx.yml"
  }

  provisioner "shell" {
    inline = ["curl -L https://github.com/aelsabbahy/goss/releases/latest/download/goss-linux-amd64 -o --create-dirs /usr/local/bin/goss", "sudo chmod -R 777 /usr/local/bin/goss", "sudo chmod +rx /usr/local/bin/goss"]
  }
}