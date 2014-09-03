FROM debian:jessie
MAINTAINER Peter Makholm <peter@makholm.net>

RUN apt-get update && apt-get install -y git-core build-essential && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src
RUN git clone https://github.com/rakudo/rakudo.git
RUN git clone https://github.com/tadzik/panda.git

WORKDIR /usr/src/rakudo
RUN perl Configure.pl --prefix=/usr/local --gen-moar --gen-parrot --gen-nqp --backends=moar,parrot && make install && make distclean

WORKDIR /usr/src/panda
RUN perl6 bootstrap.pl && cp /usr/local/languages/perl6/site/bin/* /usr/local/bin

WORKDIR /root
