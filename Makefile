default: cmd

run:
	make cmd="./bin/fmt && ./bin/deps && ./bin/build-linux && ./bin/run-linux"

fmt:
	make cmd="./bin/fmt"

build-darwin:
	make cmd="./bin/fmt && ./bin/deps && ./bin/build-darwin"

IMAGE_SHELL=go-test-shell

cmd: docker-build-shell
	docker run --interactive --tty --rm \
		--mount type="bind",source="$(PWD)",target="/go/src/app",consistency="delegated" \
		$(IMAGE_SHELL) \
		bash -c "$(cmd)"

docker-build-shell:
	docker build \
		--file ./shell.Dockerfile \
		--tag $(IMAGE_SHELL) \
		./
