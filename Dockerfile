FROM debian:jessie
MAINTAINER Peter Makholm <peter@makholm.net>

RUN apt-get update && apt-get install -y git-core build-essential && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src
RUN git clone https://github.com/MoarVM/MoarVM.git && \
    git clone https://github.com/perl6/nqp         && \
    git clone https://github.com/rakudo/rakudo.git && \
    git clone https://github.com/tadzik/panda.git

WORKDIR /usr/src/MoarVM
RUN git checkout 2014.08 && \
    perl Configure.pl --prefix=/usr/local --enable-jit && make install && make distclean

WORKDIR /usr/src/nqp
RUN git checkout 2014.08 && \
    perl Configure.pl --prefix=/usr/local --backend=moar && make install && make clean

WORKDIR /usr/src/rakudo
RUN git checkout 2014.08 && \
    perl Configure.pl --prefix=/usr/local --backend=moar && make install && make distclean

WORKDIR /usr/src/panda
RUN perl6 bootstrap.pl && cp /usr/local/languages/perl6/site/bin/* /usr/local/bin

WORKDIR /root
