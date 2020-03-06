FROM ubuntu:18.04

MAINTAINER softlabperu.com

RUN DEBIAN_FRONTEND="noninteractive" 
RUN apt-get update && apt-get install -y tzdata

RUN apt-get update && \
    apt-get install -y \
    vim \
    git \
    alien \
    nginx \
    libaio1 \
    python3 \
    supervisor \
    libssl-dev \
    python3-dev \
    python3-pip \
    libsasl2-dev \
    libldap2-dev \
    libmysqlclient-dev && \
    pip3 install -U pip setuptools uwsgi && \
    rm -rf /var/lib/apt/lists/*

ADD oracle/*.rpm /

RUN alien -i oracle-instantclient18.3-basic-18.3.0.0.0-3.x86_64.rpm && \
    alien -i oracle-instantclient18.3-devel-18.3.0.0.0-3.x86_64.rpm && \
    alien -i oracle-instantclient18.3-sqlplus-18.3.0.0.0-3.x86_64.rpm  && \
    echo "/usr/lib/oracle/18.3/client64/lib/" > /etc/ld.so.conf.d/oracle.conf && \
    ldconfig && \
    ln -s /usr/bin/sqlplus64 /usr/bin/sqlplus && \
    rm -f /*.rpm
