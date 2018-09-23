FROM microsoft/dotnet:2.1-sdk AS builder

ARG MININGCORE_REVISION

RUN apt-get update -y && \
apt-get -y install --no-install-recommends \
git cmake build-essential libssl-dev pkg-config \
libboost-all-dev libsodium-dev

WORKDIR /root/.ssh

# SHA private key from keys pair used to clone bitbucket.org private git
# repository in Dockerfile. You should generate your own keys pair and
# add public one in bitbucket account settings.
COPY private.key ./id_rsa

# Make sure domain is accepted.
RUN ssh-keyscan bitbucket.org >> known_hosts

WORKDIR /miningcore

RUN git clone git@bitbucket.org:boomstarternetwork/miningcore.git . && \
git checkout $MININGCORE_REVISION

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