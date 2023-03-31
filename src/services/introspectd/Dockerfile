FROM alpine:latest
LABEL org.opencontainers.image.source https://github.com/mschenck/lab/services/introspectd

EXPOSE 8000

RUN apk add --no-cache go

COPY main.go /

RUN go build main.go

ENTRYPOINT [ "/main" ]