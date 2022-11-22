FROM alpine:latest

ENV PROXY_PROTO "auto"
ENV LISTEN_PORT 1337
EXPOSE $PORT

RUN apk add go
RUN go install github.com/mschenck/lab/src/services/tcpecho@latest

ENTRYPOINT [ "tcpecho" ]