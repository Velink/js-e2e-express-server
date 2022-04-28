
FROM ubuntu:focal as base
LABEL maintainer="Ali Muhammad"

ENV DEPENDENCIES "software-properties-common python3 python3-pip python3-setuptools python3-software-properties sudo apt-transport-https iputils-ping wget curl gnupg gcc python3-dev xz-utils"

ENV PIP_PKGS "ansible"

# Install required dependencies
RUN  DEBIAN_FRONTEND=non-interactive apt-get update -y \
     && DEBIAN_FRONTEND=non-interactive apt-get --no-install-recommends -y upgrade \
     && DEBIAN_FRONTEND=non-interactive apt-get install --no-install-recommends -y ${DEPENDENCIES} \
     && python3 -m pip install --no-cache-dir -U pip wheel \
     && python3 -m pip install --no-cache-dir -U ${PIP_PKGS} \
     && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb \
     && for FILE in $(find /var/log -maxdepth 2 -type f); do echo "" > ${FILE}; done \
     && apt-get autoremove \
     && apt-get clean

# Install Packer

ENV PACKER_BIN_DIR /usr/local/packer/bin
RUN mkdir --parents $PACKER_BIN_DIR 

ENV PACKER_ZIP=https://releases.hashicorp.com/packer/1.7.8/packer_1.7.8_linux_amd64.zip
RUN curl -sSLo /tmp/packer.zip $PACKER_ZIP && \
  unzip /tmp/packer.zip -d $PACKER_BIN_DIR && \
  rm /tmp/packer.zip

ENV PATH $PATH:$PACKER_BIN_DIR

RUN apt-get update && \
      apt-get -y install sudo
