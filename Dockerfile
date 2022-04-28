FROM ubuntu:14.04
MAINTAINER Toshio Kuratomi <tkuratomi@ansible.com>
RUN apt-get -y update && \
    apt-get install -y python-yaml python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools python-pkg-resources git python-pip
RUN mkdir /etc/ansible/
RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts
RUN mkdir /opt/ansible/
RUN git clone http://github.com/ansible/ansible.git /opt/ansible/ansible
WORKDIR /opt/ansible/ansible
RUN git submodule update --init
ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
ENV PYTHONPATH /opt/ansible/ansible/lib
ENV ANSIBLE_LIBRARY /opt/ansible/ansible/library

# Install wget and unzip
RUN apt-get update --yes \
  && apt-get install --yes curl unzip

# Install Packer

ENV PACKER_BIN_DIR /usr/local/packer/bin
RUN mkdir --parents $PACKER_BIN_DIR 

ENV PACKER_ZIP=https://releases.hashicorp.com/packer/1.7.8/packer_1.7.8_linux_amd64.zip
RUN curl -sSLo /tmp/packer.zip $PACKER_ZIP && \
  unzip /tmp/packer.zip -d $PACKER_BIN_DIR && \
  rm /tmp/packer.zip

ENV PATH $PATH:$PACKER_BIN_DIR

# check that packer is correctly installed
RUN type packer

RUN echo "$PATH"

RUN apt-get update && \
      apt-get -y install sudo
