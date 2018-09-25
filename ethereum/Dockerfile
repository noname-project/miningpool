FROM ubuntu:18.04 AS builder

RUN apt-get update && apt-get install -y \
ca-certificates \
wget \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /

ARG ETHEREUM_VERSION

RUN wget https://releases.parity.io/v$ETHEREUM_VERSION/x86_64-unknown-linux-gnu/parity_${ETHEREUM_VERSION}_ubuntu_amd64.deb



FROM ubuntu:18.04

# WS port.
EXPOSE 11331

# RPC port.
EXPOSE 11332

# P2P port.
EXPOSE 11333

# Installing dependencies.
RUN apt-get update && apt-get install -y \
libssl1.0.0 \
&& rm -rf /var/lib/apt/lists/*

ARG ETHEREUM_VERSION

# Copying required binaries from builder stage.
COPY --from=builder /parity_${ETHEREUM_VERSION}_ubuntu_amd64.deb /

RUN dpkg -i parity_${ETHEREUM_VERSION}_ubuntu_amd64.deb

# Default config and genesis used to initalize datadir volume
# at first or cleaned deploy.
COPY parity.config.toml /root/default/config.toml

# Entrypoint script used to init datadir if required and for
# starting bitcoin daemon.
COPY entrypoint.sh /root/

# We are using exec syntax to enable graceful shutdown. Check
# http://veithen.github.io/2014/11/16/sigterm-propagation.html.
ENTRYPOINT ["bash", "/root/entrypoint.sh"]