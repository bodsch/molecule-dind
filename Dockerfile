FROM docker:stable

RUN mkdir /molecule
WORKDIR /molecule

RUN apk add --no-cache \
    build-base \
    libffi-dev \
    openssl-dev git \
    openssh-client \
    python3-dev \
    py3-cryptography \
    py3-pip \
    && ln -sv /usr/bin/python3 /usr/bin/python \
    && pip install --upgrade --no-cache-dir --ignore-installed \
      pip \
      setuptools  \
      virtualenv

COPY requirements.txt requirements.txt

RUN virtualenv .venv \
  && source .venv/bin/activate \
  && pip install --no-cache-dir -r requirements.txt
