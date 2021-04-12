FROM docker:dind
ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1

COPY requirements.txt /tmp/requirements.txt

RUN apk add --no-cache \
    build-base \
    libffi-dev \
    openssl-dev \
    git \
    openssh-client \
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
  && pip install -r /tmp/requirements.txt --no-cache-dir \
  && apk del build-base \
  && rm -rf /tmp/* \
  && mkdir /molecule

WORKDIR /molecule

ENTRYPOINT ["/usr/local/bin/dockerd-entrypoint.sh"]
CMD []
