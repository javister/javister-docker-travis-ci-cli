#!/usr/bin/env bash

set -e

. proxyenv

#usermod -d ${USER_HOME} system

if [ "${SET_GIT_PROXY}" == "yes" ] && [ ! -z "${http_proxy}" ]; then
    setuser system git config --global http.proxy ${http_proxy}
    setuser system git config --global https.proxy ${http_proxy}
fi

( setuser system bash -c "echo 'y' | HOME=${USER_HOME} travis whoami" || true ) &>/dev/null
