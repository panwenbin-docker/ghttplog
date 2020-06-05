FROM golang:latest as builder

ARG GOPROXY
ENV GORPOXY ${GOPROXY}

WORKDIR /builder

RUN git clone https://github.com/panwenbin/ghttplog.git /builder \
  && go build main.go

FROM panwenbin/alpinetz:latest

COPY --from=builder /builder/main /app/ghttplog

WORKDIR /app

CMD ["./ghttplog"]
