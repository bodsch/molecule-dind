FROM docker:dind

RUN mkdir /molecule
WORKDIR /molecule

COPY requirements.txt requirements.txt

RUN apk add --no-cache \
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
  && ln -sv /usr/bin/python3 /usr/bin/python \
  && pip install --upgrade --no-cache-dir --ignore-installed \
    pip \
    setuptools \
    virtualenv \
  && virtualenv .venv \
  && source .venv/bin/activate \
  && pip install -r requirements.txt --no-cache-dir \
  && mkdir /etc/docker \
  && echo '{ "insecure-registries" : ["0.0.0.0"] }' > /etc/docker/daemon.json \
  && rm -rf \
    /tmp/* \
    /var/cache/apk/* \
    /root/.cache \
    /root/.config \
    /molecule/requirements.txt \
  && find / -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete

ENTRYPOINT ["/usr/local/bin/dockerd-entrypoint.sh"]
CMD []
