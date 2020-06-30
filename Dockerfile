FROM docker:dind

RUN mkdir /molecule
WORKDIR /molecule

RUN apk add --no-cache build-base libffi-dev openssl-dev git \
                       openssh-client python3-dev py3-cryptography \
                       py3-pip \
  && ln -s /usr/bin/python3 /usr/bin/python \
  && python -m ensurepip \
  && rm -r /usr/lib/python*/ensurepip \
  && pip install --upgrade pip setuptools --no-cache-dir \
  && pip install virtualenv --no-cache-dir

COPY requirements.txt requirements.txt

RUN virtualenv .venv \
  && source .venv/bin/activate \
  && pip install -r requirements.txt --no-cache-dir

ENTRYPOINT ["/usr/local/bin/dockerd-entrypoint.sh"]
CMD []
