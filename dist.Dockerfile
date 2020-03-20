# --- Compile application.

FROM golang:1.14.1-buster AS builder

ENV \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /go/src/app

COPY ./app/go.* ./
RUN go mod download

COPY ./app/ ./
RUN go build -o /dist/app ./

# --- Scratch image with executable only.

FROM scratch

WORKDIR /_dist

COPY --from=builder /dist/app /_dist/app

ENTRYPOINT [ "/_dist/app" ]
