# 📓 Manual

[<< back to readme](../README.md#manual)

## [Install](#install)

[XC Copy](https://github.com/gameplayok/xc-copy) can be downloaded from the release archives.

- [Latest release](https://gameplayok.github.io/xc-copy/release/latest/)
- [All releases](https://gameplayok.github.io/xc-copy/release/)

Once the download is complete, extract the files into a target directory to use them.

## [Usage](#usage)

### Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/)

### System support

This project can be run on the following systems:
- [Debian](https://www.debian.org/download) / [Ubuntu](https://ubuntu.com/download/desktop)
- [Mac OS](https://www.apple.com/ca/macos)
- [Windows](https://www.microsoft.com/en-ca/windows)

### Configuration

Ensure that `xc-copy` is properly configured before sending/receiving data.

#### [Environment variables](#environment-variables)

Update the variable values in the `.env` file.

| Name                 | Description                                                | Default   | Required |
| -------------------- | ---------------------------------------------------------- | --------- | -------- |
| `XBOX_FTP_ID`        | Username                                                   | `xbox`    | Yes      |
| `XBOX_FTP_KEY`       | Password                                                   | `xbox`    | Yes      |
| `XBOX_HOST_IP`       | Xbox host IP address                                       |           | Yes      |
| `XBOX_ID`            | Xbox MAC address or UUID                                   |           | Yes      |
| `XBOX_LOCAL_SOURCE`  | Comma-separated local source directories for sent files    |           | Yes      |
| `XBOX_LOCAL_TARGET`  | Target directory for received files                        |           | Yes      |
| `XBOX_NAME`          | Custom Xbox name                                           |           | Yes      |
| `XBOX_REMOTE_SOURCE` | Comma-separated Xbox source directories for received files | `/C/,/E/` | Yes      |
| `XBOX_REMOTE_TARGET` | Xbox target directory for sent files                       |           | Yes      |

### Transferring files

Run the following commands from the parent directory of the `compose.yaml` file.

#### Receive

```sh
> docker-compose up receive
```

#### Send

```sh
> docker-compose up send
```

## [Development](#development)

### Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/)
- [wget](https://linux.die.net/man/1/wget)
- [wput](https://linux.die.net/man/1/wput)

### System support

This project can be developed on the following systems:
- [Debian](https://www.debian.org/download) / [Ubuntu](https://ubuntu.com/download/desktop)
- [Mac OS](https://www.apple.com/ca/macos)
- [Windows subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install)

### Source Code

#### Get a copy of the repository

```
> git clone https://github.com/gameplayok/xc-copy.git
```

*For detailed instructions on cloning a repo, go [here](https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/cloning-a-repository)*

Alternatively, the latest project archive can be downloaded in the `zip` file format.  
[![download-zip-button](asset/image/download-zip-button.png)](https://github.com/gameplayok/xc-copy/archive/main.zip)

### Configuration

#### Environment variables

To update environment variables:
- Copy `src/config/default.env` to `src/.env`

For more information please review the [Usage](#usage)->Configuration->[Environment variables](#environment-variables) section.

#### Run the setup script

```
> cd /path/to/xc-copy
> ./dev/util/setup.sh
```

### Transferring files

Run the following commands from the `src` directory:

#### Receive

```sh
# Docker
> docker-compose up --build receive

# Shell script
> ./util/receive.sh
```

#### Send

```sh
# Docker
> docker-compose up --build send

# Shell script
> ./util/send.sh
```

### [Formatting](#formatting)

Format shell scripts with [shfmt](https://github.com/patrickvane/shfmt).

```
> ./dev/util/format.sh
```

### [Testing](#testing)

#### Running spec files

Run shell tests with [shellspec](https://shellspec.info/).

```
> ./test/util/spec.sh
```

#### [Writing tests](#writing-tests)

The tests for `xc-copy` can be found in [test/spec](../test/spec).  
All shell tests are run through [shellspec](https://shellspec.info/) which is a full-featured BDD unit testing framework for *nix shells.

```sh
It "should have no uncommitted changes"
    check_git_status(){
        result=$(git status -s)

        if [ -z "${result}" ]; then
            result='pass'
        else
            result='fail'
        fi

        printf '%s' "${result}"
    }

    When call check_git_status
    The output should equal 'pass'
End
```

#### Linting project files

Lint shell scripts with [shellcheck](https://shellcheck.com/).

```
> ./test/util/lint.sh
```

#### Checking the release steps

Ensure the `main` branch is ready for release.

```
> ./test/util/release.sh
```

[<< back to readme](../README.md#manual)
