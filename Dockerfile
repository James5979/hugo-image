FROM docker.io/library/debian:stable-20240110-slim AS build

ARG HUGO_VERSION=0.121.2

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-amd64.deb /var/cache/apt/archives/

RUN dpkg --install \
    /var/cache/apt/archives/hugo_${HUGO_VERSION}_linux-amd64.deb && \
    rm -rf /var/cache/apt/archives/hugo_${HUGO_VERSION}_linux-amd64.deb

RUN mkdir /hugo

FROM scratch

COPY --from=build /usr/local/bin/hugo /usr/bin/hugo

COPY --from=build /hugo /hugo

WORKDIR /hugo

EXPOSE 1313

ENTRYPOINT ["/usr/bin/hugo"]

CMD ["--help"]
