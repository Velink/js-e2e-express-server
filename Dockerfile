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

RUN pip3 install --upgrade pip; \
    pip3 install --upgrade virtualenv; \
    pip3 install pywinrm[kerberos]; \
    pip3 install pywinrm; \
    pip3 install jmspath; \
    pip3 install requests; \
    python3 -m pip install ansible; 