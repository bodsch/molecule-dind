FROM docker:stable

RUN apk add --no-cache python build-base python2-dev libffi-dev openssl-dev openssh-client git\
  && python -m ensurepip \
  && rm -r /usr/lib/python*/ensurepip \
  && pip install --upgrade pip setuptools \
  && pip install virtualenv \
  && rm -r /root/.cache
