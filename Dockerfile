FROM ubuntu:20.04
RUN useradd -rm -s /bin/bash  -G sudo -u 71000 ansible
RUN groupmod -g 71000 ansible
USER ansible

RUN apt-get update && \
    apt-get install -y \
        openssh-server

RUN mkdir -p /ansible/.ssh && \
    chmod 0700 /ansible/.ssh && 
# Add the keys and set permissions
ADD keys/id_rsa /ansible/.ssh/id_rsa
ADD keys/id_rsa.pub /ansible/.ssh/id_rsa.pub
RUN chmod 600 /ansible/.ssh/id_rsa && \
    chmod 600 /ansible/.ssh/id_rsa.pub

# Authorize SSH Host
RUN cat /ansible/.ssh/id_rsa.pub > /ansible/.ssh/known_hosts


RUN service ssh start

EXPOSE 22