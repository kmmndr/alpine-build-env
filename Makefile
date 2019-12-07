docker_run_env = docker run --rm -it --privileged -v ${HOME}:/home/builder -v /var/run/docker.sock:/var/run/docker.sock:ro

.PHONY: qemu-static
qemu-static:
	$(info Building qemu-static)
	@docker build --tag qemu-static -f Dockerfile.qemu-static .
	@-docker container rm qemu-static
	@-docker create --name qemu-static qemu-static
	@sudo docker cp qemu-static:/usr/local/bin/qemu-arm-static /usr/local/bin/qemu-arm-static

.PHONY: binfmt_misc_arm32v7
binfmt_misc_arm32v7: qemu-static
	$(info Register binfmt if needed)
	@if [ ! -f /proc/sys/fs/binfmt_misc/arm32v7 ]; then \
		sudo mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc 2> /dev/null; \
		sudo su -c "echo ':arm32v7:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/local/bin/qemu-arm-static' > /proc/sys/fs/binfmt_misc/register"; \
	fi

.PHONY: amd64
amd64: Dockerfile.amd64
	docker build --tag alpine-build-env-amd64 -f Dockerfile.amd64 .
	$(docker_run_env) alpine-build-env-amd64 /bin/ash

.PHONY: arm32v7
arm32v7: Dockerfile.arm32v7 binfmt_misc_arm32v7
	docker build --tag alpine-build-env-arm32v7 -f Dockerfile.arm32v7 .
	$(docker_run_env) alpine-build-env-arm32v7 /bin/ash

.PHONY: binfmt_misc_unregister_arm32v7
binfmt_misc_unregister_arm32v7:
	$(info Unregistering binfmt_misc/arm32v7)
	@if [ -f /proc/sys/fs/binfmt_misc/arm32v7 ]; then \
		sudo su -c "echo -1 > /proc/sys/fs/binfmt_misc/arm32v7"; \
	fi

.PHONY: rm-qemu-static
rm-qemu-static:
	$(info Removing docker image)
	@-docker rm qemu-static

.PHONY: clean
clean: binfmt_misc_unregister_arm32v7 rm-qemu-static
