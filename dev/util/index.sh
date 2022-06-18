#!/usr/bin/env sh

script_path=$(readlink -f ../../dev/util/template.sh)
eval "ls | $script_path > index.html"

cmd="cd '{}' && eval \"ls | $script_path > index.html\""
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "${cmd}" \;
