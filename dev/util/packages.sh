#!/usr/bin/env sh

set -eu

platform=$(uname -s | tr '[:upper:]' '[:lower:]')

shellspec_install_msg="> Installing 'shellspec' BDD framework | https://shellspec.info"

if [ "${platform}" = 'linux' ]; then
	if ! command -v shellspec >/dev/null 2>&1; then
		printf '\n%s\n' "$shellspec_install_msg"

		if [ -n "${CI}" ]; then
			wget -c "https://github.com/shellspec/shellspec/releases/download/0.28.1/shellspec-dist.tar.gz" -O - | tar -zx
			ln -s "$PWD"/shellspec/shellspec /usr/local/bin/shellspec
		else
			wget -O- https://git.io/shellspec | sh
		fi

		shellspec --init
	fi
elif [ "${platform}" = 'darwin' ]; then
	if command -v brew >/dev/null 2>&1; then
		printf '\n%s\n' "$shellspec_install_msg"
		brew tap shellspec/shellspec
		brew install shellspec
		shellspec --init
	else
		printf '%s\n' "> 'homebrew' not found - https://brew.sh/"
		exit 127
	fi
fi
