FROM debian:bullseye-slim AS tar
ARG WF_VERSION=0.13.1
ADD https://github.com/writefreely/writefreely/releases/download/v${WF_VERSION}/writefreely_${WF_VERSION}_linux_amd64.tar.gz /tmp/writefreely_${WF_VERSION}_linux_amd64.tar.gz
RUN tar xf /tmp/writefreely_${WF_VERSION}_linux_amd64.tar.gz -C /usr/local && apt-get update && apt-get install -y ca-certificates

FROM debian:bullseye-slim
COPY --from=tar /etc/ssl/certs /etc/ssl/certs
COPY --from=tar /usr/local/writefreely /usr/local/writefreely
WORKDIR /usr/local/writefreely
ENV PATH="/usr/local/writefreely:$PATH"
CMD [ "/usr/local/writefreely/writefreely" ]
