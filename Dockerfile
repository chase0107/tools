FROM google/cloud-sdk:alpine

ARG KUBECTL_VERSION=1.16.7
ENV KUSTOMIZE_VER 2.0.3

RUN apk add --no-cache --update curl ca-certificates

RUN echo "KUBECTL_VERSION: ${KUBECTL_VERSION}" \
    && curl -Lo /usr/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
    && chmod +x /usr/bin/kubectl \
    && /usr/bin/kubectl version --client

RUN curl -L https://github.com/kubernetes-sigs/kustomize/releases/download/v${KUSTOMIZE_VER}/kustomize_${KUSTOMIZE_VER}_linux_amd64  -o /usr/bin/kustomize \
    && chmod +x /usr/bin/kustomize

RUN curl -L https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/aws-iam-authenticator -o /usr/bin/aws-iam-authenticator \
    && chmod +x /usr/bin/aws-iam-authenticator \
    && export PATH=$PATH:$HOME/bin \
    && echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

CMD ["/usr/bin/aws-iam-authenticator"]