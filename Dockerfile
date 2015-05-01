FROM ubuntu:14.04
MAINTAINER jesse.miller@adops.com
# This file is based on https://docs.docker.com/examples/running_ssh_service/

RUN apt-get update && apt-get install -y \
    git \
    libpq-dev \
    openssh-server \
    python \
    python-dev \
    python-pip \
    python-psycopg2

# Install psql client tools
COPY pg-client-install.sh /tmp/
RUN /tmp/pg-client-install.sh


RUN mkdir /var/run/sshd
RUN echo 'root:sandbox' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# ENV NOTVISIBLE "in users profile"
# RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
