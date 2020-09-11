FROM docker:dind

COPY requirements.txt /tmp/requirements.txt

RUN apk add --quiet --no-cache \
    build-base \
    libffi-dev \
    openssl-dev \
    git \
    openssh-client \
    sudo \
    docker-py \
    python3-dev \
    py3-cryptography \
    py3-pip \
  && ln -sf \
    /usr/bin/python3 /usr/bin/python \
  && pip install \
    --quiet --upgrade --no-cache-dir --ignore-installed \
    pip \
    setuptools \
    virtualenv \
  && virtualenv --quiet .venv \
  && source .venv/bin/activate \
  && pip install \
    --quiet --no-cache-dir --requirement /tmp/requirements.txt \
  && mkdir /molecule \
  && mkdir /etc/docker \
  && echo "{ "insecure-registries" : ["0.0.0.0"] } " > /etc/docker/daemon.json \
  && rm -rf \
    /tmp/* \
    /var/cache/apk/* \
    /root/.cache \
    /root/.config \
    /tmp/requirements.txt \
  && find /molecule -type d -name __pycache__ -exec rm -rf {} \; || true

COPY unsecure-registries.sh /usr/local/bin/unsecure-registries.sh
COPY entrypoint.sh /usr/local/bin/dockerd-entrypoint.sh

WORKDIR /molecule

ENTRYPOINT ["/usr/local/bin/dockerd-entrypoint.sh"]
CMD []
