#!/bin/bash

set -eu

HADOLINT_VERSION='1.18.0'
HADOLINT_PATH="${HOME}/bin/hadolint"

if [ ! -x "${HADOLINT_PATH}" ]
then
  mkdir -vp $(dirname "${HADOLINT_PATH}")

  curl \
    --silent \
    --location \
    --output "${HADOLINT_PATH}" \
    "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64"
  chmod +x "${HADOLINT_PATH}"
fi

${HADOLINT_PATH} \
  --ignore DL3013 \
  --ignore DL3018 \
  --ignore SC1091 \
  Dockerfile

if [ -n $(command -v shellcheck) ]
then
  shellcheck \
    --external-sources \
    *.sh
fi
