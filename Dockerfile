# build app
FROM golang:1-alpine AS builder

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -trimpath

# build runner
FROM scratch

COPY --from=builder /src/privtracker /
COPY docs /docs

EXPOSE 1337

ENTRYPOINT ["/privtracker"]
