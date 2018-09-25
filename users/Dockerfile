FROM ubuntu:18.04
LABEL maintainer="Edoardo Morassutto <edoardo.morassutto@gmail.com>"

# setup the base system
RUN apt update -yy
RUN apt install -yy systemd zsh vim openssh-server
RUN yes | unminimize

ENV container=docker

COPY setup.sh /setup.sh

# startup command
CMD ["/bin/systemd", "--system"]
