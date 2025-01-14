#!/usr/bin/env bash

# get our global env vars
source args.sh $@

#
# If k8s is just spinning up this can fail, so we use a retry-loop
#

function getArgoPwd() {
  echo "****************** getting ArgoCD credentials ******************"
  export MY_ARGO_PWD=$(kubectl -n "$MY_ARGO_NAMESPACE" get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)
}


# our retry-loop
i=1
getArgoPwd
while [ -z "$MY_ARGO_PWD" ]
do
  echo "(retry $i) waiting for argo to start..."
  sleep 3
  i=$(( $i + 1 ))
  getArgoPwd
done
echo "MY_ARGO_PWD is $MY_ARGO_PWD"

function doArgoLogin() {
  
  echo "****************** getting ArgoCD IP ******************"
  which jq || brew install jq
  # export MY_ARGO_IP=$(kubectl -n "$MY_ARGO_NAMESPACE" get svc argocd-server -o json | jq '.status.loadBalancer.ingress | .[].ip' | tr -d '"')
  
  export MY_ARGO_IP=$(kubectl get svc argocd-server -o json | jq '.status.loadBalancer.ingress | .[].ip' | tr -d '"')
  echo "MY_ARGO_IP is $MY_ARGO_IP"

  echo "****************** log in to ArgoCD $MY_ARGO_IP w/ user admin, pwd $MY_ARGO_PWD ******************"
  argocd login "$MY_ARGO_IP" --password "$MY_ARGO_PWD" --username admin --insecure

  echo "open https://$MY_ARGO_IP"

}

function checkArgoLogin() {
  argocd account get
}
retVal=$?
echo "check argo login returned $retVal"
if [ $retVal -ne 0 ]; then
    doArgoLogin()
else
    echo "already logged into argo"
fi

