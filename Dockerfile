FROM alpine:latest AS build-watchman

RUN apk upgrade && apk add git bash libtool autoconf automake pkgconfig alpine-sdk openssl-dev linux-headers
WORKDIR /tmp
RUN git clone https://github.com/facebook/watchman.git
WORKDIR /tmp/watchman
RUN \
  git checkout v4.9.0 && \
  ./autogen.sh && \
  ./configure && \
  make && \
  make install && \
  watchman -v

FROM node:10-alpine
RUN apk upgrade && apk add openssl-dev make nginx
COPY --from=build-watchman /usr/local/bin/watchman /usr/local/bin
CMD ["sh"]
