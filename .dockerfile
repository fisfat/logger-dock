FROM golang:1.20.5-alpine as builder 

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o logger ./cmd/api

RUN chmod +x /app/logger

FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/logger /app

CMD [ "/app/logger" ]

