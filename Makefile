default: cmd

run:
	make cmd="./bin/vet-code && ./bin/build-linux && ./bin/run-linux"

build-darwin:
	make cmd="./bin/vet-code && ./bin/build-darwin"

IMAGE_SHELL=go-test-shell

cmd:
	mkdir -p ./_dist
	mkdir -p ./_temp/cache
	mkdir -p ./_temp/pkg

	docker build \
		--file ./shell.Dockerfile \
		--tag $(IMAGE_SHELL) \
		./

	docker run --interactive --tty --rm \
		--mount type="bind",source="$(PWD)",target="/go/src/app",consistency="delegated" \
		--mount type="bind",source="$(PWD)/_temp/cache",target="/go/cache",consistency="delegated" \
		--mount type="bind",source="$(PWD)/_temp/pkg",target="/go/pkg",consistency="delegated" \
		--env GOCACHE=/go/cache \
		$(IMAGE_SHELL) \
		bash -c "$(cmd)"
