#!/usr/bin/env bash

#set -x

# functions for creating an EKS cluster and setting local kubectl config

export CLUSTER_NAME=${CLUSTER_NAME:-ebg-dev}
export AWS_REGION=${AWS_REGION:-eu-west-2}
export NODE_TYPE=${NODE_TYPE:-"t3.small"}
export NODE_COUNT=${NODE_COUNT:-5}

echo "CLUSTER_NAME : $CLUSTER_NAME"
echo "AWS_REGION   : $AWS_REGION"
echo "NODE_TYPE    : $NODE_TYPE"
echo "NODE_COUNT   : $NODE_COUNT"

function installEKSCTL() {
    echo "installing eksctl"
    brew tap weaveworks/tap
    brew install weaveworks/tap/eksctl
}

function ensureEKSCTL() {
    echo -ne "checking EKSCTL `which eksctl`\r"
    echo "checking eksctl `which eksctl`"
    which eksctl || installEKSCTL
}

function createCluster() {
    # https://us-east-1.console.aws.amazon.com/systems-manager/parameters/aws/service/eks/optimized-ami/1.24/amazon-linux-2/recommended/image_id/description?region=eu-west-2#
    echo "creating cluster"
    eksctl create cluster \
        --name $CLUSTER_NAME \
        --region $AWS_REGION \
        --nodegroup-name ${CLUSTER_NAME}-nodes \
        --node-type $NODE_TYPE \
        --nodes $NODE_COUNT
}

function deleteCluster() {
    eksctl delete cluster --name $CLUSTER_NAME
}

function ensureClusterCreated() {
    clusterInfo=`getCluster`
    retVal=$?
    if [[ ! $retVal ]]; then
      echo "cluster (CLUSTER_NAME='$CLUSTER_NAME') returned $retVal, looks like it exists?"
      echo "\n$clusterInfo\n"
    else
      createCluster
    fi
}

function getCluster() {
    eksctl get cluster --name=$CLUSTER_NAME  --region=$AWS_REGION
}

function updateLocalKubeConfig() {
    echo "updating kubectl config"
    # https://docs.aws.amazon.com/cli/latest/reference/sts/get-caller-identity.html
    # aws sts get-caller-identity

    aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME
}