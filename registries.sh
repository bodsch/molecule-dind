#!/bin/sh

# set -eu

registries=

if [ -n "${DOCKER_UNSECURE_REGISTRIES}" ]
then
  registries=$(echo ${DOCKER_UNSECURE_REGISTRIES} | sed -e 's/,/","/g' -e 's/\s+/\n/g' | uniq)
fi

if [[ ! -z "${registries}" ]]
then
    echo "{ \"insecure-registries\": " > /etc/docker/daemon.json
    printf '  ["%s"],\n' "${registries}" | sed '$s/,$//' >> /etc/docker/daemon.json
    echo "}" >> /etc/docker/daemon.json
fi

cat /etc/docker/daemon.json
