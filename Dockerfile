FROM golang:1.18-alpine AS build

WORKDIR /app

COPY ["go.mod", "go.sum", "./"]

RUN go mod download

COPY main.go ./

RUN go build -o server main.go

FROM alpine:latest

WORKDIR /app

COPY --from=build /app/server /app/server

ENTRYPOINT ["/app/server"]
