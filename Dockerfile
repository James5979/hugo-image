FROM debian:stable-slim

ARG HUGO_VERSION=0.111.3

ADD https://github.com/gohugoio/hugo/releases/download/v0.111.3/hugo_${HUGO_VERSION}_linux-amd64.deb /var/cache/apt/archives/

RUN dpkg --install \
    /var/cache/apt/archives/hugo_${HUGO_VERSION}_linux-amd64.deb && \
    rm -rf /var/cache/apt/archives/hugo_${HUGO_VERSION}_linux-amd64.deb && \
    mv /usr/local/bin/hugo /usr/bin/hugo

VOLUME /usr/local/src
WORKDIR /usr/local/src

EXPOSE 1313

ENTRYPOINT ["hugo"]
CMD ["--help"]
