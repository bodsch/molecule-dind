FROM docker:stable

RUN mkdir /molecule
WORKDIR /molecule

RUN apk add --no-cache python build-base python2-dev libffi-dev openssl-dev git openssh-client\
  && python -m ensurepip \
  && rm -r /usr/lib/python*/ensurepip \
  && pip install --upgrade pip setuptools --no-cache-dir \
  && pip install virtualenv --no-cache-dir

COPY requirements.txt requirements.txt

RUN virtualenv .venv \
  && source .venv/bin/activate \
  && pip install -r requirements.txt --no-cache-dir \
