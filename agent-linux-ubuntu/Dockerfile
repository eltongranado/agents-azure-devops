FROM ubuntu:22.04

RUN apt update && \
    apt upgrade -y && \
    apt install -y curl git jq libicu70 unzip openjdk-11-jre

ENV TARGETARCH="linux-x64" \
    JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

WORKDIR /azp/

COPY ./start.sh ./

RUN chmod +x ./start.sh

# Another option is to run the agent as root.
ENV AGENT_ALLOW_RUNASROOT="true"

ENTRYPOINT ./start.sh