# 💾 Setup

[<< back to docs](../README.md#contributing)

## System requirements

The system requirements can be installed by running:

```sh
> . ./dev/util/setup.sh
```

### Application overview

#### [pipx](https://pipxproject.github.io/pipx/)

Creates an isolated environment for Python applications and their associated packages.

```sh
> pip install pipx
```

#### [commitizen](https://commitizen-tools.github.io/commitizen/)

A set of linting rules and tooling for standardized commit workflows. 

```sh
> pipx install commitizen
```

#### [pre-commit](https://pre-commit.com/)

Manages the installation and execution of any hook written in any language before every commit.

```sh
> pipx install pre-commit
> pre-commit install --hook-type commit-msg
> pre-commit install
```

[<< back to docs](../README.md#contributing)
