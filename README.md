# Build environment for AlpineLinux

To create `apk` packages for alpine, you need an AlpineLinux environment. The
fastest way to have such environment is to use latest docker image. This
project is a quick way to enter into AlpineLinux's world :-)

# Prerequisite

The only requirement is `docker`, `make`, `git`, and `sudo` on your linux
workstation, but you probably have it installed already.

# Usage

The main make targets are `amd64` and `arm32v7`.

## Amd64 environment

This is the simplest way to use the environment, as it is just an AlpineLinux
docker image and an entrypoint to initialize abuild configuration before
starting a shell

To access `amd64` environment, simply run

```shell
make amd64
```

## Arm32v7 environment

To have an arm environment on a amd64 host, we'll need docker, qemu and
`binfmt_misc` linux capability. Qemu executable is provided by
[qemu-arm](https://pkgs.alpinelinux.org/package/edge/main/x86_64/qemu-arm)
package and copied to host from docker image. Then it is registered as `arm`
executable interpreter using
[binfmt_misc](https://en.wikipedia.org/wiki/Binfmt_misc)

To access `arm32v7` environment, simply run

```shell
make arm32v7
```

## Specific alpine release

By default, `alpine-edge` is used as base image, but this can be overridden by
`ALPINE_RELEASE` env variable

```shell
make amd64 -e ALPINE_RELEASE=3.10
```
