#!/bin/bash
set -meuo pipefail

EMARK_DIR=/emark/.eMark/
EMARK_CONF=/emark/.eMark/eMark.conf

if [ -z "${EMARK_RPCPASSWORD:-}" ]; then
  # Provide a random password.
  EMARK_RPCPASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 24 ; echo '')
fi

if [ ! -e "${EMARK_CONF}" ]; then
  tee -a >${EMARK_CONF} <<EOF
server=1
rpcuser=${EMARK_RPCUSER:-emarkv1rpc}
rpcpassword=${EMARK_RPCPASSWORD}
rpcclienttimeout=${EMARK_RPCCLIENTTIMEOUT:-30}
EOF
echo "Created new configuration at ${EMARK_CONF}"
fi

if [ $# -eq 0 ]; then
  /emark/eMark/src/eMarkd -rpcbind=:6666 -rpcallowip=* -printtoconsole=1
else
  exec "$@"
fi
