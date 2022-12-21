#!/usr/bin/env bash

set -x

export KIND_K8S_CONFIG_PATH=${KIND_K8S_CONFIG_PATH:-"$HOME/.kube/config-kind"}

function currentContext() {
    kubectl config current-context 
}

function setNamespace() {
    echo "setting namespace to $NAMESPACE"
    [[ -z "$NAMESPACE" ]] && (echo "NAMESPACE arg required" && exit 1) || kubectl config set-context --current --namespace=$NAMESPACE
}

function showContexts() {
    echo "Context Names: "
    kubectl config get-contexts -o name
    echo "Context Details: "
    kubectl config get-contexts
}

function unsetNamespace() {
    kubectl config set-context --current --namespace=default
}


function init() {
    which kind || brew install kind
}

function setKubeconfigToLocal() {
    echo "KIND_K8S_CONFIG_PATH is $KIND_K8S_CONFIG_PATH"
    #kubectl config --kubeconfig=$KIND_K8S_CONFIG_PATH use-context kind-kind
    kubectl config  use-context kind-kind
}

function useContext() {
    [[ -z "$NAME" ]] && (echo "NAME not set" && exit 1) || kubectl config use-context $NAME
}

function deleteLocalCluster() {
    kind delete cluster 
}

function localClusterInfo() {
    kubectl cluster-info --context kind-kind
}

function ensureLocalCluster() {
    clusters=`kind get clusters`
    retVal=$?
    if [[ $retVal ]]; then
      echo "we've got a local 'kubernetes in docker' cluster:\n$clusters\n"
    else
      echo "creating a local cluster"
      kind create cluster --kubeconfig $KIND_K8S_CONFIG_PATH
    fi
}