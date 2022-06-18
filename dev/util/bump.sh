#!/usr/bin/env sh

set -eu

if command -v cz >/dev/null 2>&1; then
	printf '%s\n' "> Bumping version with 'commitizen' | https://commitizen-tools.github.io/commitizen/"
	eval "cz bump --changelog ${*:-}"

	version=$(cat ./.version)

	rm -rf "./docs/release/latest"
	rm -rf "./docs/release/${version}"
	mkdir -p "./docs/release/${version}"

	./dev/util/build.sh
	cd ./build

	release_id="../docs/release/${version}/xc-copy-${version}"

	printf '%s\n' "> Creating a build archive"
	tar -czvf "${release_id}.tar.gz" compose.yaml docs/ README.md LICENSE >/dev/null 2>&1

	printf '%s\n' "> Generating an MD5 checksum"
	md5sum "${release_id}.tar.gz" >"${release_id}.md5"

	cd ..

	printf '%s\n' "> Creating a source code archive"
	git archive --format tar HEAD | gzip >"${release_id#?}-source.tar.gz"
	md5sum "${release_id#?}-source.tar.gz" >"${release_id#?}-source.md5"

	this_dir=$(pwd)

	cd ./docs/release
	../../dev/util/index.sh
	cd "${this_dir}"

	mkdir -p "./docs/release/latest"

	xc_copy_latest_index_html=$(
		cat <<EOF
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta http-equiv="refresh" content="0;URL='../${version}/'" />
	</head>
	<body>
		<a href="../${version}/">Download the latest copy of xc-copy</a>
	</body>
</html>
EOF
	)

	printf '%s\n' "${xc_copy_latest_index_html}" >./docs/release/latest/index.html

	git add "./docs/release/"
	git commit --amend --no-edit
	git tag -f "${version}"
	./test/util/release.sh
else
	printf '%s\n' "> 'commitizen' not found - https://commitizen-tools.github.io/commitizen/"
	printf '%s\n' "> Run 'pipx install commitizen' to install it"
fi
