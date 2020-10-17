FROM ubuntu:18.04

RUN DEBIAN_FRONTEND="noninteractive" 
RUN apt-get update && apt-get install -y tzdata

RUN apt-get update && \
    apt-get install -y \
    vim \
    git \
    xvfb \
    wget \
    alien \
    nginx \
    telnet \
    libaio1 \
    python3 \
    supervisor \
    libssl-dev \
    python3-dev \
    python3-pip \
    libsasl2-dev \
    libldap2-dev \
    libfreetype6 \
    libfontconfig1 \
    libfreetype6-dev \
    libfontconfig1-dev \
    fonts-liberation \
    chromium-chromedriver \
    libmysqlclient-dev && \
    pip3 install -U pip setuptools uwsgi && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb && \
    rm -f /google-chrome-stable_current_amd64.deb

RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    mv phantomjs-2.1.1-linux-x86_64 /usr/local/share && \
    ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin && \
    rm -f /*.tar.bz2

ADD oracle/*.rpm /

RUN alien -i oracle-instantclient18.3-basic-18.3.0.0.0-3.x86_64.rpm && \
    alien -i oracle-instantclient18.3-devel-18.3.0.0.0-3.x86_64.rpm && \
    alien -i oracle-instantclient18.3-sqlplus-18.3.0.0.0-3.x86_64.rpm && \
    echo "/usr/lib/oracle/18.3/client64/lib/" > /etc/ld.so.conf.d/oracle.conf && \
    ldconfig && \
    ln -s /usr/bin/sqlplus64 /usr/bin/sqlplus && \
    rm -f /*.rpm
