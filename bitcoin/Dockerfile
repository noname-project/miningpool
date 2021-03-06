FROM ubuntu:18.04 AS builder

RUN apt-get update && apt-get install -y \
ca-certificates \
curl \
&& rm -rf /var/lib/apt/lists/*

ARG BITCOIN_VERSION

RUN curl https://bitcoin.org/bin/bitcoin-core-$BITCOIN_VERSION/bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz \
| tar xz --wildcards --strip 2 \
*/bin/bitcoind \
*/bin/bitcoin-cli



FROM ubuntu:18.04

# RPC port.
EXPOSE 8332

# P2P port.
EXPOSE 8333

# ZeroMQ port.
EXPOSE 8334

RUN echo 'alias cli="bitcoin-cli -rpcuser=$BITCOIN_RPC_USER -rpcpassword=$BITCOIN_RPC_PASSWORD"' > /root/.bash_aliases

# Copying required binaries from builder stage.
COPY --from=builder bitcoind bitcoin-cli /usr/local/bin/

# Default config used to initalize datadir volume at first or
# cleaned deploy. It will be restored and used after each restart.
COPY bitcoin.conf /root/default/bitcoin.conf

# Entrypoint script used to init datadir if required and for
# starting bitcoin daemon.
COPY entrypoint.sh /root/

# We are using exec syntax to enable graceful shutdown. Check
# http://veithen.github.io/2014/11/16/sigterm-propagation.html.
ENTRYPOINT ["bash", "/root/entrypoint.sh"]