# --- Toolkit for running commands.

FROM golang:1.14.1-buster AS builder

ENV \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

RUN go get golang.org/x/tools/cmd/goimports

# Mount this folder on docker run.
WORKDIR /go/src/app
