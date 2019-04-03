FROM ubuntu:14.04
#TODO use a docker with jre already installed

# Prerequisites
RUN apt-get update
RUN apt-get install -y software-properties-common

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq 
RUN apt-get install -y locales -qq 
#RUN locale-gen fr_FR.UTF-8 fr_FR 
RUN dpkg-reconfigure locales
#RUN locale-gen C.UTF-8 
RUN /usr/sbin/update-locale LANG=C.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

# Install Java 8
run add-apt-repository -y ppa:webupd8team/java
run apt-get update
run echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
run apt-get install -y oracle-java8-installer
RUN mkdir -p /source/config
RUN mkdir -p /batch/config

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ADD run.sh /run.sh
RUN chmod 755 /*.sh
CMD ["/run.sh"]