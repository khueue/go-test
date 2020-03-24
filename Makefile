default:
	@ cat Makefile

IMAGE_SHELL=go-test-shell

run:
	make cmd cmd="bash ./bin/run.sh"

fmt:
	make cmd cmd="bash ./bin/fmt.sh"

cmd: build-shell
	docker run --interactive --tty --rm \
		--mount type="bind",source="$(PWD)",target="/go/src/app",consistency="delegated" \
		$(IMAGE_SHELL) \
		$(cmd)

build-shell:
	docker build \
		--file ./shell.Dockerfile \
		--tag $(IMAGE_SHELL) \
		./
