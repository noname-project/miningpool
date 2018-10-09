FROM microsoft/dotnet:2.1-sdk AS builder

RUN apt-get update -y && \
apt-get -y install --no-install-recommends \
cmake build-essential libssl-dev pkg-config \
libboost-all-dev libsodium-dev

WORKDIR /miningcore

ARG MININGCORE_REVISION

RUN curl -L https://github.com/boomstarternetwork/miningcore/archive/$MININGCORE_REVISION.tar.gz \
| tar xz --strip 1

WORKDIR /miningcore/src/MiningCore

RUN bash ./linux-build.sh



FROM microsoft/dotnet:2.1-runtime

# API port.
EXPOSE 4000

# Stratum ports.
EXPOSE 3000-3004

# Install dependencies
RUN apt-get update && \
apt-get install -y --no-install-recommends \
libboost-system1.62.0 libboost-date-time1.62.0 libssl1.0.2 libsodium18 && \
rm -rf /var/lib/{apt,dpkg,cache,log,lists} /tmp/* /var/tmp/*

WORKDIR /miningcore

# Copying required binaries from builder stage.
COPY --from=builder /miningcore/build/* ./

# Config used to run miningcore.
COPY miningcore.config.json config.json

# We are using exec syntax to enable graceful shutdown. Check
# http://veithen.github.io/2014/11/16/sigterm-propagation.html.
ENTRYPOINT ["dotnet", "MiningCore.dll", "-c", "./config.json"]