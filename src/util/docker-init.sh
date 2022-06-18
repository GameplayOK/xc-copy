#!/usr/bin/env sh

set -e

# Initialize the container
/usr/bin/dumb-init -- "${@}"
