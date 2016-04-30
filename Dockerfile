# Adapted from https://github.com/markmandel/wrapping-clojure-tooling-in-containers

FROM centos:centos7

# emacs rpm
RUN yum update -y && \
    yum install -y wget zsh && \
    # Emacs dependencies
    yum install -y gtk2-devel libXpm-devel libtiff-devel libjpeg-devel libungif-devel ncurses-devel && \
    rpm -ivh https://s3.amazonaws.com/epxlabs-rpms/emacs-24.5-1.el7.centos.x86_64.rpm

# Git recent version
RUN yum erase -y git && yum clean all
RUN yum groupinstall -y "Development Tools" && yum install -y gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel
RUN wget https://github.com/git/git/archive/v2.8.2.tar.gz && tar -xvzf v2.8.2.tar.gz && cd git-2.8.2 && make all && make install && cd ..

# java
RUN wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie;" http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-x64.rpm && \
    wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie;" http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jre-8u77-linux-x64.rpm && \
    rpm -ivh jdk-8u77-linux-x64.rpm && rpm -ivh jre-8u77-linux-x64.rpm && \
    rm jdk-8u77-linux-x64.rpm && rm jre-8u77-linux-x64.rpm

# xpra
RUN rpm --import https://winswitch.org/gpg.asc && \
    wget -P /etc/yum.repos.d/ https://winswitch.org/downloads/CentOS/winswitch.repo && \
    yum install -y xpra

#oh-my-zsh, because how do we live without it?
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git

# lein
ENV LEIN_ROOT=1
RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -P /usr/local/bin && chmod +x /usr/local/bin/lein && lein

ADD startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

RUN mkdir /project
WORKDIR /project

# SSH
RUN yum -y install openssh-server passwd && mkdir /var/run/sshd && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''

EXPOSE 22
