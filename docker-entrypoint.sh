#!/bin/bash
set -e

/etc/init.d/rabbitmq-server start
/etc/init.d/redis-server start
/etc/init.d/supervisor start

echo 'Removing old locks'
rm -f /tmp/*.lock

if [ "$2" = "--enable-interceptor-client" ]; then
  echo 'Starting interceptord'
  interceptord.py &
fi

echo 'Starting jasmind'
exec "$@"
