FROM buildpack-deps:jessie
MAINTAINER Peter Makholm <peter@makholm.net>

WORKDIR /usr/src
RUN git clone https://github.com/MoarVM/MoarVM.git && \
    git clone https://github.com/perl6/nqp         && \
    git clone https://github.com/rakudo/rakudo.git && \
    git clone https://github.com/rakudo/star.git rakudo-star && (cd rakudo-star ; git submodule update --init )

ENV RAKUDO_GIT_TAG 2014.09
ENV RAKUDO_STAR_GIT_TAG ec742d5d9c

WORKDIR /usr/src/MoarVM
RUN git checkout $RAKUDO_GIT_TAG && \
    perl Configure.pl --prefix=/usr/local --enable-jit && make install && make distclean

WORKDIR /usr/src/nqp
RUN git checkout $RAKUDO_GIT_TAG && \
    perl Configure.pl --prefix=/usr/local --backend=moar && make install && make clean

WORKDIR /usr/src/rakudo
RUN git checkout $RAKUDO_GIT_TAG && \
    perl Configure.pl --prefix=/usr/local --backend=moar && make install && make distclean

WORKDIR /usr/src/rakudo-star
RUN git checkout $RAKUDO_STAR_GIT_TAG && \
    /usr/bin/perl tools/build/module-install.pl /usr/local/bin/perl6-m /usr/local/languages/perl6/lib moarvm mbc modules/MODULES.txt && \
    /usr/bin/perl tools/build/bin-install.pl /usr/local/bin/perl6-m /usr/local/bin m modules/ufo/bin/ufo modules/panda/bin/panda modules/doc/bin/p6doc

WORKDIR /root
