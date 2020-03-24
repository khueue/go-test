FROM golang:1.14.1-buster

# Tooling unrelated to app.
RUN go get golang.org/x/tools/cmd/goimports

# Mount repo root to this folder on run.
WORKDIR /go/src/app
