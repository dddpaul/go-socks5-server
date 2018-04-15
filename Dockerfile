FROM golang:1.10.1 as builder
WORKDIR /go/src/github.com/dddpaul/socks5-server
ADD . ./
RUN make build-alpine

FROM alpine:latest
RUN apk add --update ca-certificates && \
    rm -rf /var/cache/apk/* /tmp/* && \
    update-ca-certificates
WORKDIR /app
COPY --from=builder /go/src/github.com/dddpaul/socks5-server/bin/socks5-server .

EXPOSE 1080
ENTRYPOINT ["./socks5-server"]
