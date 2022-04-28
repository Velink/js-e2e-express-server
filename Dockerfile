FROM ubuntu
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

RUN apt-get update && \
      apt-get -y install sudo && \
      apt install software-properties-common && \
      add-apt-repository --yes --update ppa:ansible/ansible && \
      apt install ansible

RUN type ansible

RUN echo "$PATH"