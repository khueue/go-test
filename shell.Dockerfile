FROM golang:1.14.1-buster

ENV \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Tooling unrelated to app.
RUN go get golang.org/x/tools/cmd/goimports

# Mount repo root to this folder on run.
WORKDIR /go/src/app
