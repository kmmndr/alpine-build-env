# Build environment for AlpineLinux packages

To create `apk` packages for alpine, you need an AlpineLinux environment. The
fastest way to have such environment is to use latest docker image. This
project is a quick way to enter into AlpineLinux's world :-)

# Prerequisite

The only requirement is `docker`, `make`, `git`, and `sudo` on your
workstation, but you probably have it installed already.

# Usage

The main make targets are `amd64` and `arm32v7` to enter arch specific
environments.

```shell
make amd64
```

```shell
make arm32v7
```
