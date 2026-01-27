FROM openbao/openbao:2.4.1

ARG TARGETOS=linux
ARG TARGETARCH=amd64

ENV ARGOCD_VERSION=2.13.4
ENV KUBECTL_VERSION=1.35.0

RUN apk add --no-cache \
    ca-certificates \
    curl \
    openssl \
    age \
    bash \
  && update-ca-certificates

RUN curl -fsSL "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl" \
      -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl

RUN curl -fsSL "https://github.com/argoproj/argo-cd/releases/download/v${ARGOCD_VERSION}/argocd-${TARGETOS}-${TARGETARCH}" \
      -o /usr/local/bin/argocd \
  && chmod +x /usr/local/bin/argocd

ENTRYPOINT ["/bin/sh"]
