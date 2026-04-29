FROM openbao/openbao:2.4.1

ARG TARGETOS=linux
ARG TARGETARCH=amd64

ENV ARGOCD_VERSION=2.13.4
ENV KUBECTL_VERSION=1.35.0
ARG RCLONE_VERSION=1.72.0

RUN apk add --no-cache \
    ca-certificates \
    curl \
    openssl \
    age \
    bash \
    unzip \
  && update-ca-certificates

RUN curl -fsSL "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl" \
      -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl

RUN curl -fsSL "https://github.com/argoproj/argo-cd/releases/download/v${ARGOCD_VERSION}/argocd-${TARGETOS}-${TARGETARCH}" \
      -o /usr/local/bin/argocd \
  && chmod +x /usr/local/bin/argocd

RUN curl -fsSL "https://github.com/rclone/rclone/releases/download/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-${TARGETOS}-${TARGETARCH}.zip" \
      -o /tmp/rclone.zip \
  && unzip /tmp/rclone.zip -d /tmp/rclone \
  && mv /tmp/rclone/rclone-v${RCLONE_VERSION}-${TARGETOS}-${TARGETARCH}/rclone /usr/local/bin/rclone \
  && chmod +x /usr/local/bin/rclone \
  && rm -rf /tmp/rclone /tmp/rclone.zip

ENTRYPOINT ["/bin/sh"]