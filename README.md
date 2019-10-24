# Build environment for AlpineLinux packages

To create `apk` packages for alpine, you need an AlpineLinux environment. The
fastest way to have such environment is to use latest docker image. This
project is a quick way to enter into AlpineLinux's world :-)

# Prerequisite

The only requirement is `docker` (and `docker-compose` optionally) on your
workstation, but you probably have it installed already.

# Usage

Using `docker-compose`:
```shell
docker-compose build
docker-compose run alpine-build-env /bin/ash
```

Then, into your alpine's environment you can use the script
`init-alpine-build-env` to initialize required stuff.
