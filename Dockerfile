# syntax=docker/dockerfile:
FROM hashicorp/packer
COPY . /app
#ENV PACKER_BIN_DIR /usr/local/packer/bin
#CMD ["curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -", "sudo apt-add-repository \"deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main\"", "sudo apt-get update && sudo apt-get install packer"]
#ENV PATH $PATH:$PACKER_BIN_DIR