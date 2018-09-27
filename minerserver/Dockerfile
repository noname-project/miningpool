FROM golang:1.11 AS builder

WORKDIR /root/.ssh

# SHA private key from keys pair used to clone bitbucket.org private git
# repository in Dockerfile. You should generate your own keys pair and
# add public one in bitbucket account settings.
COPY private.key ./id_rsa

# Make sure domain is accepted.
RUN ssh-keyscan bitbucket.org >> known_hosts

WORKDIR /go/src/minerserver

RUN go get -u github.com/golang/dep/...

ARG MINERSERVER_REVISION

RUN git clone git@bitbucket.org:boomstarternetwork/minerserver.git . && \
git checkout $MINERSERVER_REVISION

RUN dep ensure -v
RUN CGO_ENABLED=0 go install -v ./...



FROM alpine:3.8

EXPOSE 80

COPY --from=builder /go/bin/minerserver /usr/local/bin/

# We are using exec syntax to enable graceful shutdown. Check
# http://veithen.github.io/2014/11/16/sigterm-propagation.html.
ENTRYPOINT ["minerserver"]