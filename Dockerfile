FROM ubuntu:21.04

RUN DEBIAN_FRONTEND="noninteractive" 
RUN apt update && apt install -y tzdata

RUN apt update && \
    apt install -y \
    vim \
    git \
    xvfb \
    wget \
    alien \
    nginx \
    wmctrl \
    x11vnc \
    telnet \
    libgbm1 \
    libaio1 \
    libnss3 \
    python3 \
    fluxbox \
    libnspr4 \
    libcups2 \
    libcairo2 \
    xdg-utils \
    supervisor \
    libssl-dev \
    libgtk-3-0 \
    python3-dev \
    python3-pip \
    libsasl2-dev \
    libldap2-dev \
    libfreetype6 \
    libxkbcommon0 \
    libpango-1.0-0 \
    libfontconfig1 \
    libfreetype6-dev \
    fonts-liberation \
    libmysqlclient-dev \
    libfontconfig1-dev \
    libatk-bridge2.0-0 \
    libmysqlclient-dev && \
    pip3 install -U pip setuptools && \
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

RUN alien -i oracle-instantclient-basic-21.1.0.0.0-1.x86_64.rpm && \
    alien -i oracle-instantclient-devel-21.1.0.0.0-1.x86_64.rpm && \
    alien -i oracle-instantclient-sqlplus-21.1.0.0.0-1.x86_64.rpm && \
    echo "/usr/lib/oracle/21/client64/lib/" > /etc/ld.so.conf.d/oracle.conf && \
    ldconfig && \
    #ln -s /usr/bin/sqlplus64 /usr/bin/sqlplus && \
    rm -f /*.rpm

ENV DISPLAY=:99
