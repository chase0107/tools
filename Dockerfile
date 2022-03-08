FROM google/cloud-sdk:alpine

RUN apk add --no-cache \
        python3 \
        py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install --no-cache-dir \
        awscli \
    && rm -rf /var/cache/apk/*

RUN aws --version   # Just to make sure its installed alright

ARG KUBECTL_VERSION=1.20.5
ARG KUSTOMIZE_VER=3.8.7

RUN apk add --no-cache --update curl ca-certificates

RUN echo "KUBECTL_VERSION: ${KUBECTL_VERSION}" \
    && curl -Lo /usr/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
    && chmod +x /usr/bin/kubectl \
    && /usr/bin/kubectl version --client

RUN curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/v2.0.3/kustomize_2.0.3_linux_amd64  -o /usr/bin/kustomize \
    && chmod +x /usr/bin/kustomize

CMD ["/usr/bin/kustomize"]