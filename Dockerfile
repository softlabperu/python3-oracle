FROM ubuntu:18.04

# Install required packages and remove the apt packages cache when done.

MAINTAINER Softlabperu

RUN apt-get update && \
    apt-get install -y \
    alien \
    libaio1 \
	  python3 \
  	python3-dev \
  	python3-pip \
  	libmysqlclient-dev \
  	python3-setuptools && \
  	pip3 install -U pip setuptools && \
    rm -rf /var/lib/apt/lists/*

ADD *.rpm /

RUN alien -i oracle-instantclient18.3-basic-18.3.0.0.0-1.x86_64.rpm && \
    alien -i oracle-instantclient18.3-devel-18.3.0.0.0-1.x86_64.rpm && \
    echo "/usr/lib/oracle/18.3/client64/lib/" > /etc/ld.so.conf.d/oracle.conf && \
    ldconfig && \
    ln -s /usr/bin/sqlplus64 /usr/bin/sqlplus
