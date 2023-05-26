FROM debian:stable-slim

ARG HUGO_VERSION=0.112.2
ARG HUGO_UID=101
ARG HUGO_GID=101

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-amd64.deb /var/cache/apt/archives/

RUN dpkg --install \
    /var/cache/apt/archives/hugo_${HUGO_VERSION}_linux-amd64.deb && \
    rm -rf /var/cache/apt/archives/hugo_${HUGO_VERSION}_linux-amd64.deb && \
    mv /usr/local/bin/hugo /usr/bin/hugo && \
    mkdir --parents /var/hugo && \
    chown $HUGO_UID:$HUGO_GID /var/hugo && \
    useradd \
    --comment="hugo" \
    --home-dir=/var/hugo \
    --no-create-home \
    --shell=/usr/sbin/nologin \
    --uid=$HUGO_UID \
    --system \
    hugo

VOLUME /usr/local/src
WORKDIR /var/hugo

EXPOSE 1313

USER hugo:hugo

ENTRYPOINT ["hugo"]
CMD ["--help"]
