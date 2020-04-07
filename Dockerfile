FROM golang:1.14 as builder

ARG GOPROXY
ENV GORPOXY ${GOPROXY}

WORKDIR /builder

RUN git clone https://github.com/panwenbin/ghttplog.git /builder \
  && go build main.go

FROM alpine:latest

RUN mkdir /lib64 \
  && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY --from=builder /builder/main /app/ghttplog

WORKDIR /app

CMD ["./ghttplog"]
