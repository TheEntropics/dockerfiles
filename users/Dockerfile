FROM ubuntu:18.04
LABEL maintainer="Edoardo Morassutto <edoardo.morassutto@gmail.com>"

# setup the base system
RUN apt update -yy
RUN apt install -yy systemd zsh vim openssh-server
RUN yes | unminimize
RUN locale-gen it_IT.UTF-8 && update-locale LANG=it_IT.UTF-8
RUN mkdir /root/.ssh && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCmDi2VFyBLgEAcftTVcZ99A6bnKJXLo2DiCanOUx1Hyy2A2V/2ppsbyO285jvQeXfb+vRxHLsZdrtzzdCOvMj0ircihsRzNfgA5IxTEConKgpe22SxGWjfeS7ir4NtUEgunaxsCoE4OVnXxCzlKqZy1n3MvBQB5F3cflwDy97VWJ2RedCYsTpGh5mlamgMJUm0XHPZYlPgA3YfUFyOG8kdqPRv3I5aV+B4+0yMB1HfuY+D1VXatq101am6nbckIrhq8geBmUo4DO+QCicialts9AYq9N2+MbLOS+qeGPH3uS9RwXCwASEmhuLPodmvs9ZQqKWsoXpwfVGwZDG2c6L1 root@serben" > /root/.ssh/authorized_keys

ENV container=docker

COPY setup.sh /setup.sh

# startup command
CMD ["/bin/systemd", "--system"]
