FROM ubuntu:20.04
RUN useradd -rm -s /bin/bash  -G sudo -u 71000 ansible
RUN groupmod -g 71000 ansible

RUN apt-get update && \
    apt-get install -y \
        openssh-server

RUN mkdir -p /home/ansible/.ssh && \
    chmod 0700 /home/ansible/.ssh
# Add the keys and set permissions
ADD ./keys/id_rsa /home/ansible/.ssh/id_rsa
ADD ./keys/id_rsa.pub /home/ansible/.ssh/id_rsa.pub
RUN ls -al /home/ansible/.ssh/
RUN  chmod 600 /home/ansible/.ssh/id_rsa && \
     chmod 600 /home/ansible/.ssh/id_rsa.pub 


# Authorize SSH Host
RUN cat /home/ansible/.ssh/id_rsa.pub > /home/ansible/.ssh/known_hosts

EXPOSE 22
ENTRYPOINT service ssh start
CMD ["/sbin/init"]
