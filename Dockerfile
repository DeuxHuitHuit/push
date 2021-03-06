#
# Ubuntu Node.js Dockerfile
#
# https://github.com/dockerfile/ubuntu/blob/master/Dockerfile
# https://docs.docker.com/examples/nodejs_web_app/
#
FROM ubuntu:20.04

# arguments definition
ARG opdomain
ARG opemail
ARG opsecretkey
ARG opsvnentry

# get repo updates
RUN apt-get update

# install dependencies
RUN apt-get install -y bash
RUN apt-get install -y curl
RUN apt-get install -y jq
RUN apt-get install -y unzip
RUN apt-get install -y rsync
RUN apt-get install -y subversion
RUN apt-get install -y openssh-client

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# download 1password cli
RUN curl -s https://cache.agilebits.com/dist/1P/op/pkg/v1.8.0/op_linux_386_v1.8.0.zip > op_linux_386_v1.8.0.zip
RUN unzip op_linux_386_v1.8.0.zip
RUN mv op /usr/local/bin

# install ssh key
ADD ssh /root/.ssh
RUN chmod 600 /root/.ssh/id_rsa

# add checkout script
ADD checkout.sh /checkout.sh

# env vars for 1password
ENV OP_AUTH_DOMAIN=${opdomain}
ENV OP_AUTH_EMAIL=${opemail}
ENV OP_AUTH_SECRET_KEY=${opsecretkey}
ENV OP_SVN_ENTRY=${opsvnentry}
ENV OP_SLACK_WEBHOOK="wqc4uhvhwrtqbcueg2zbe4x7lq"
