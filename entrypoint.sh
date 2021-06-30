#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for rails.
rm -f /myapp/tmp/pids/server.pid

# Then execute the container's main process (what is set as CMD in the Dockerfile)
exec "$@"