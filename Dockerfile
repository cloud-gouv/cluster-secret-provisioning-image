FROM openbao/openbao:2.4.1

ENV ARGOCD_VERSION=2.13.4

RUN apk add --no-cache \
    curl \
    ca-certificates

RUN curl -fsSL \
      https://github.com/argoproj/argo-cd/releases/download/v${ARGOCD_VERSION}/argocd-linux-amd64 \
      -o /usr/local/bin/argocd \
    && chmod +x /usr/local/bin/argocd

ENTRYPOINT ["/bin/sh"]
