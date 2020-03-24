default:
	@ cat Makefile

IMAGE_SHELL=go-test-shell

run:
	make cmd cmd="./bin/fmt && ./bin/deps && ./bin/build-linux && ./bin/run-linux"

# build-darwin:
# 	make cmd cmd="./bin/fmt && ./bin/deps && ./bin/build-darwin"

fmt:
	make cmd cmd="./bin/fmt"

cmd: build-shell
	docker run --interactive --tty --rm \
		--mount type="bind",source="$(PWD)",target="/go/src/app",consistency="delegated" \
		$(IMAGE_SHELL) \
		bash -c "$(cmd)"

build-shell:
	docker build \
		--file ./shell.Dockerfile \
		--tag $(IMAGE_SHELL) \
		./
