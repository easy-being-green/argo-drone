#!/usr/bin/env bash


export NAME=${NAME:-example}
export ORG=${ORG:-easybeinggreenuk}
export GITHASH=`git rev-parse --short HEAD`
export VERSION=${VERSION:-$GITHASH}
export REPO=${REPO:-https://github.com/easy-being-green/argo-drone.git}
export NS=${NS:-example-test}

build() {
    docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7  . -t "$ORG/$NAME:$VERSION" -t "$ORG/$NAME:latest" --push
}

run() {
    docker run -p 80:8080 -d "$NAME"
}

# assumes argo login
argoCreate() {
    kubectl get namespace "$NS" || (echo "creating namespace $NS" && kubectl create namespace "$NS")

    argocd app create "$NAME" \
        --repo "$REPO" \
        --path example-app/k8s \
        --dest-namespace "$NS" \
        --dest-server https://kubernetes.default.svc \
        --auto-prune \
        --self-heal \
        --revision dev \
        --sync-policy auto \
        --directory-recurse
}