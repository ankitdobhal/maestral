FROM python:3.9.1-alpine3.13

ARG UID=1000
ARG VERSION

RUN set -eux ; \
  adduser -D -u ${UID} -h /dropbox dropbox ; \
  apk add --no-cache --virtual .build-deps \
    gcc \
    musl-dev \
    python3-dev \
    libffi-dev \
    openssl-dev \
    cargo ; \
  pip install maestral==${VERSION} ; \
  rm -rf /root/.cargo; \
  rm -rf /root/.cache; \
  apk del --no-network .build-deps

USER dropbox
VOLUME ["/dropbox"]
WORKDIR /dropbox

CMD ["maestral", "start", "-f"] 
