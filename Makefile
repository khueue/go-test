default: cmd

server:
	docker run --interactive --tty --rm \
		--mount type="bind",source="$(PWD)",target="/workdir",consistency="delegated" \
		--mount type="bind",source="$(PWD)/_dist/wasm",target="/workdir/web/go",consistency="delegated" \
		--workdir "/workdir" \
		--publish 8000:8000 \
		python:2 \
		bash -c "cd ./web && python ./server.py"

watch:
	make cmd="./bin/watch"

debug-run:
	make cmd="./bin/vet && cd ./src && dlv debug ./"

debug-test:
	make cmd="./bin/vet && cd ./src && dlv test ./"

run:
	make cmd="./bin/vet && ./bin/test && ./bin/build-linux && ./bin/run-linux"

build-wasm:
	make cmd="./bin/vet && ./bin/test && ./bin/build-wasm"

build-darwin:
	make cmd="./bin/vet && ./bin/test && ./bin/build-darwin"

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
