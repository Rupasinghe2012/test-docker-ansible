FROM ubuntu:20.04
RUN useradd -rm -s /bin/bash  -G sudo -u 71000 ansible
RUN groupmod -g 71000 ansible

RUN apt-get update && \
    apt-get install -y \
        openssh-server \
        sudo

COPY ./files/ssh_config /home/ansible/.ssh/config
RUN mkdir -p /home/ansible/.ssh && \
    chmod 0700 /home/ansible/.ssh
# Add the keys and set permissions
ADD ./keys/id_rsa /home/ansible/.ssh/id_rsa
ADD ./keys/id_rsa.pub /home/ansible/.ssh/id_rsa.pub
RUN  chmod 600 /home/ansible/.ssh/id_rsa && \
     chmod 600 /home/ansible/.ssh/id_rsa.pub 


# Authorize SSH Host
COPY ./keys/id_rsa.pub /home/ansible/.ssh/authorized_keys

RUN chown -R ansible:ansible /home/ansible/ && \
  echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ADD ./files/wait-for /home/ansible/wait-for

EXPOSE 22
ENTRYPOINT service ssh restart && bash
