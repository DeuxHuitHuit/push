#
# Ubuntu Node.js Dockerfile
#
# https://github.com/dockerfile/ubuntu/blob/master/Dockerfile
# https://docs.docker.com/examples/nodejs_web_app/
#
FROM ubuntu:20.04

# arguments definition
ARG svnuser
ARG svnpassword
ARG opdomain
ARG opemail
ARG opsecretkey

# get repo updates
RUN apt-get update

# install dependencies (some are probably already installed anyway)
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y jq
RUN apt-get install -y unzip
RUN apt-get install -y rsync
RUN apt-get install -y subversion

# install nodejs
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# download 1password cli
RUN wget https://cache.agilebits.com/dist/1P/op/pkg/v1.8.0/op_linux_386_v1.8.0.zip
RUN unzip op_linux_386_v1.8.0.zip
RUN mv op /usr/local/bin

# install ssh key
RUN mkdir ~/.ssh
ADD deuxhuithuit-push-tmp/.ssh $HOME

# login the svn user https://unix.stackexchange.com/a/451882
RUN rm -rf ~/.subversion
RUN yes yes | svn --username=${svnuser} --password=${svnpassword} ls https://svn.288dev.com:8443/svn/288/ &>/dev/null

# env vars for 1password
ENV OP_AUTH_DOMAIN=${opdomain}
ENV OP_AUTH_EMAIL=${opemail}
ENV OP_AUTH_SECRET_KEY=${opsecretkey}
