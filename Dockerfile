FROM openbao/openbao:2.4.1

ENV ARGOCD_VERSION=2.13.4
ENV KUBECTL_VERSION=1.35.0

RUN apk add --no-cache \
    ca-certificates \
    curl \
    openssl \
    age \
    bash \
  && update-ca-certificates

RUN curl -fsSL https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
      -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && /usr/local/bin/kubectl version --client=true --output=yaml >/dev/null

RUN curl -fsSL \
      https://github.com/argoproj/argo-cd/releases/download/v${ARGOCD_VERSION}/argocd-linux-amd64 \
      -o /usr/local/bin/argocd \
    && chmod +x /usr/local/bin/argocd

ENTRYPOINT ["/bin/sh"]
