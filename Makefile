default:
	@ cat Makefile

TAG_DIST=go-dist
TAG_SHELL=go-shell

build-dist:
	docker build \
		--file ./app/dist.Dockerfile \
		--tag $(TAG_DIST) \
		./

build-shell:
	docker build \
		--file ./app/shell.Dockerfile \
		--tag $(TAG_SHELL) \
		./

run: build-dist
	docker run --interactive --tty --rm \
		$(TAG_DIST)

vet: build-shell
	docker run --interactive --tty --rm \
		--mount type="bind",source="$(PWD)",target="/go/src/app",consistency="delegated" \
		$(TAG_SHELL) \
		bash -c "goimports -w ./app/"
