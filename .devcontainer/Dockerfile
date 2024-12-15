FROM ubuntu:latest

RUN apt-get update

# General deps
RUN apt-get install -y \
    git

# Open PBS deps
RUN apt-get install -y \
    autoconf \
    automake \
    gcc \
    hwloc \
    libhwloc-dev \
    libx11-dev \
    libxt-dev \
    libedit-dev \
    libical-dev \
    libncurses-dev \
    perl \
    python3-dev \
    tcl-dev \
    tk-dev \
    swig \
    libexpat1-dev \
    libssl-dev \
    libcjson1 \
    libcjson-dev \
    expat \
    libedit2 \
    postgresql \
    postgresql-contrib \
    postgresql-server-dev-all \
    sendmail-bin \
    sudo \
    libical3

# Open PBS PTL deps
RUN  apt-get install -y \
    python3 \
    python3-pip \
    python3-bs4 \
    python3-defusedxml \
    python3-pexpect \
    python3-pytest \
    python3-nose