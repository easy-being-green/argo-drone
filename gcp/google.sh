#!/usr/bin/env bash

export PROJECT_ID=${PROJECT_ID:-wired-dahlia-372514}
export REGION=${REGION:-europe-west2}
export NAME=${NAME:-cluster-dev}

initKubeCtl() {
    # see https://www.bitpoke.io/docs/app-for-wordpress/basic-usage/connect-to-cluster-and-access-k8s-pods/
    gcloud container clusters get-credentials $NAME --region $REGION --project "$PROJECT_ID"


    # for first-time setup, see
    # https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
    export USE_GKE_GCLOUD_AUTH_PLUGIN=True
    gcloud components update
    gcloud container clusters get-credentials $NAME

    # see https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
    gcloud components install gke-gcloud-auth-plugin
}

# just use "show command-line" in gcloud
createCluster() {
    # gcloud config set project "$PROJECT_ID"
    gcloud container --project "$PROJECT_ID" \
    clusters create-auto "$NAME" \
    --region "$REGION" \
    --release-channel "regular" \
    --network "projects/$PROJECT_ID/global/networks/default" \
    --subnetwork "projects/$PROJECT_ID/regions/$REGION/subnetworks/default" \
    --cluster-ipv4-cidr "/17" \
    --services-ipv4-cidr "/22"
}