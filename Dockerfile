FROM docker:stable

ENV PIP_CACHE_DIR /molecule/.pip

RUN apk add --no-cache python build-base python2-dev libffi-dev openssl-dev \
  && python -m ensurepip \
  && rm -r /usr/lib/python*/ensurepip \
  && pip install --upgrade pip setuptools \
  && pip install virtualenv \
  && rm -r /root/.cache

RUN virtualenv /molecule/.venv \
  && source /molecule/.venv/bin/activate \
  && pip install ansible molecule jmespath docker-py

WORKDIR /molecule
