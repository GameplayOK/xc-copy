#!/usr/bin/env sh

set -eu

if [ -n "${XBOX_HOST_IP:-}" ]; then
    if [ -z "${XBOX_ID:-}" ]; then
        printf '%s\n' "> Error: 'XBOX_ID' variable is not set or it is an empty string"
        exit 127
    fi

    if [ -z "${XBOX_NAME:-}" ]; then
        printf '%s\n' "> Error: 'XBOX_NAME' variable is not set or it is an empty string"
        exit 127
    fi

    if [ -z "${XBOX_FTP_ID:-}" ]; then
        printf '%s\n' "> Error: 'XBOX_FTP_ID' variable is not set or it is an empty string"
        exit 127
    fi

    if [ -z "${XBOX_FTP_KEY:-}" ]; then
        printf '%s\n' "> Error: 'XBOX_FTP_KEY' variable is not set or it is an empty string"
        exit 127
    fi

    if [ -z "${XBOX_REMOTE_SOURCE:-}" ]; then
        printf '%s\n' "> Error: 'XBOX_REMOTE_SOURCE' variable is not set or it is an empty string"
        exit 127
    fi

    if [ -n "${DOCKERIZE:-}" ]; then
        export XBOX_LOCAL_TARGET=/xbox/backup
    fi

    if [ -z "${XBOX_LOCAL_TARGET:-}" ]; then
        printf '%s\n' "> Error: 'XBOX_LOCAL_TARGET' variable is not set or it is an empty string"
        exit 127
    fi

    console_tag="${XBOX_NAME}-${XBOX_ID}"
    ftp_url="ftp://${XBOX_FTP_ID:-}:${XBOX_FTP_KEY:-}@${XBOX_HOST_IP:-}"

    printf '%s\n' "> Connecting to '${XBOX_FTP_ID:-}@${XBOX_HOST_IP:-}'"
    wget -q --spider "${ftp_url}"

    if [ "${?}" -eq 0 ]; then
        for path in $(echo ${XBOX_REMOTE_SOURCE} | sed "s/,/ /g"); do
            printf '%s\n' "> Copying '${path:-}' to '${XBOX_LOCAL_TARGET:-}/${console_tag}${path:-}'"
            wget -nv --show-progress -nH -m -c -N -P "${XBOX_LOCAL_TARGET}/${console_tag}" "${ftp_url}${path}"
        done;
    else
        printf '\n%s\n' "> Error: Could not establish a connection to '${XBOX_HOST_IP:-}'"
        exit 127
    fi
else
    printf '%s\n' "> Error: 'XBOX_HOST_IP' variable is not set or it is an empty string"
    exit 127
fi
