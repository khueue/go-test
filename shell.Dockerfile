# --- Toolkit for running commands.

FROM golang:1.14.1-buster AS builder

ENV \
	GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /go/src/app

RUN go get golang.org/x/tools/cmd/goimports
