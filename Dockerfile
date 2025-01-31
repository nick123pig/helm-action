FROM alpine:3.15

ENV BASE_URL="https://get.helm.sh"

ENV HELM_3_FILE="helm-v3.9.0-linux-amd64.tar.gz"

RUN apk add --no-cache ca-certificates \
    --repository http://dl-3.alpinelinux.org/alpine/edge/community/ \
    jq curl bash nodejs aws-cli && \
    curl -L ${BASE_URL}/${HELM_3_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    helm init
    
ENV PYTHONPATH "/usr/lib/python3.8/site-packages/"

COPY . /usr/src/
ENTRYPOINT ["node", "/usr/src/index.js"]
