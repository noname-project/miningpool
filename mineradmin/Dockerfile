FROM golang:1.11 AS builder

RUN go get github.com/golang/dep/...

WORKDIR /go/src/github.com/boomstarternetwork/mineradmin

ARG MINERADMIN_REVISION

WORKDIR $GOPATH/src/github.com/boomstarternetwork/mineradmin

RUN curl -L https://github.com/boomstarternetwork/mineradmin/archive/$MINERADMIN_REVISION.tar.gz \
| tar xz --strip 1

RUN dep ensure -v

RUN go test ./...

RUN CGO_ENABLED=0 go install -v .



FROM alpine:3.8

EXPOSE 80

COPY --from=builder /go/bin/mineradmin /usr/local/bin/

# We are using exec syntax to enable graceful shutdown. Check
# http://veithen.github.io/2014/11/16/sigterm-propagation.html.
ENTRYPOINT ["mineradmin"]