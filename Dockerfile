FROM docker:dind

ARG BUILD_DATE
ARG BUILD_VERSION
ARG VCS_REF

LABEL \
  org.version=${BUILD_VERSION} \
  org.build-date=${BUILD_DATE} \
  org.vcs-ref=${VCS_REF}

COPY requirements.txt /tmp/requirements.txt

RUN apk add \
    bash \
    build-base \
    libffi-dev \
    openssl-dev \
    yq \
    jq \
    git \
    openssh-client \
    sudo \
    docker-py \
    python3-dev \
    py3-cryptography \
    py3-pip \
    cargo \
    rust \
  && ln -sf \
    /usr/bin/python3 /usr/bin/python \
  && pip install \
    --quiet --upgrade --no-cache-dir --ignore-installed \
    pip \
    setuptools \
  && pip install \
    --requirement /tmp/requirements.txt \
  && apk del \
    cargo \
    rust \
    build-base \
    openssl-dev \
    libffi-dev \
    python3-dev \
  && mkdir /molecule \
  && mkdir /etc/docker \
  && echo '{ "insecure-registries" : ["0.0.0.0"] }' > /etc/docker/daemon.json \
  && rm -rf \
    /tmp/* \
    /var/cache/apk/* \
    /root/.cache \
    /root/.config \
  && find / -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete \
  && echo "" \
  && ansible --version \
  && ansible-lint --version \
  && tox --version \
  && echo ""

COPY unsecure-registries.sh /usr/local/bin/unsecure-registries.sh
COPY entrypoint.sh /usr/local/bin/dockerd-fixed-entrypoint.sh

ENV OSTYPE=docker
# WORKDIR /molecule
ENTRYPOINT ["/usr/local/bin/dockerd-fixed-entrypoint.sh"]
CMD []
