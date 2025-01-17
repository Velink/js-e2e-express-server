packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "ubuntu-ami-with-ansible-nginx"
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
  ssh_interface = "public_ip"
  ssh_username = "ubuntu"
  encrypt_boot = "true"
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    inline = ["sudo apt-get update", "sudo apt-get -y install sudo", "sudo apt install -y software-properties-common", "sudo add-apt-repository --yes --update ppa:ansible/ansible", "sudo apt install -y ansible", "ansible --version"]
  }

  provisioner "ansible-local" {
    playbook_file = "install_nginx.yml"
  }

  provisioner "shell" {
    inline = ["service nginx status"]
  }

  provisioner "shell" {
    inline = ["sudo chmod -R 777 /usr/local/bin/", "ls -ld /usr/local/bin/", "curl -L https://github.com/aelsabbahy/goss/releases/latest/download/goss-linux-amd64 -o /usr/local/bin/goss", "chmod +rx /usr/local/bin/goss"]
  }

  provisioner "shell" {
    inline = ["goss --version", "nginx -v", "ansible --version"]
  }

  provisioner "file" {
    source = "goss.yaml"
    destination = "/tmp/goss.yaml"
  }

  provisioner "shell" {
    inline = ["cd /tmp/", "goss validate"]
  }
}