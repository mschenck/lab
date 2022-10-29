FROM alpine:latest

EXPOSE 8000

RUN apk add --no-cache go

COPY main.go /

RUN go build main.go

ENTRYPOINT [ "/main" ]