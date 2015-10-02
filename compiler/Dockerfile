FROM debian:jessie

MAINTAINER Michael Hendricks <michael@ndrix.org>

# prepare OS
RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y build-essential curl libarchive13 libarchive-dev libgmp-dev libossp-uuid-dev libreadline-dev libssl-dev zlib1g-dev
RUN apt-get clean

# obtain SWI Prolog source
RUN mkdir swipl-src
RUN curl 'http://www.swi-prolog.org/download/devel/src/swipl-7.3.7.tar.gz' | tar -x -z --strip-components=1 -C /swipl-src -f -
ADD build swipl-src/build

# build SWI Prolog
RUN cd swipl-src && ./build
RUN tar czf swipl-binary.tgz swipl
