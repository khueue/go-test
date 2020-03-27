FROM golang:1.14.1-buster

RUN apt-get update \
	&& apt-get install -y \
		upx \
		inotify-tools \
	&& apt-get clean

# Tooling unrelated to app.
# - goimports: gofmt but also fixes imports.
# - richgo: go test with colours.
# - dlv: debugger.
RUN go get \
	golang.org/x/tools/cmd/goimports \
	github.com/kyoh86/richgo \
	github.com/go-delve/delve/cmd/dlv

# Mount repo root to this folder on run.
WORKDIR /go/src/app
