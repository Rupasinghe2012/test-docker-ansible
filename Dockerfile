FROM ubuntu:20.04
RUN useradd -rm -s /bin/bash  -G sudo -u 71000 ansible
RUN groupmod -g 71000 ansible

RUN apt-get update && \
    apt-get install -y \
        openssh-server
USER ansible
RUN mkdir -p /home/ansible/.ssh && \
    chmod 0700 /home/ansible/.ssh
# Add the keys and set permissions
ADD ./keys/id_rsa /home/ansible/.ssh/id_rsa
ADD ./keys/id_rsa.pub /home/ansible/.ssh/id_rsa.pub
RUN sudo chmod 600 /home/ansible/.ssh/id_rsa && \
    sudo chmod 600 /ansible/.ssh/id_rsa.pub

# Authorize SSH Host
RUN cat /home/ansible/.ssh/id_rsa.pub > /ansible/.ssh/known_hosts


RUN sudo service ssh start

EXPOSE 22