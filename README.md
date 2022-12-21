# argo-demo
A demo use of [Argo CD](https://argo-cd.readthedocs.io/en/stable/) ([docs](https://argo-cd.readthedocs.io/en/stable/)). 


## Pre-requisites
- A GitHub account (other repositories are available)
- [Homebrew](https://brew.sh) is installed (assumes mac)

> Note:
> This guide assumes the use of MacOS with permissions to be able to install various apps

### 1) Set up a Kubernetes Cluster
See:
 * [aws](./aws/readme.md)
 * [azure](./azure/readme.md)
 * [gcp](./gcp/readme.md)
 * [kube](./kube/readme.md) <- for local k8s using kind

From here, we assume `kubectl` is installed/authenticated.

### 2) Deploy Argo to Kubernetes

### 8) With argo in place, we can install drone

See [here](./docs/installDrone.md) to set up the OAuth app in github.

Then run [installDrone.sh](installDrone.sh) with the github oauth client ID and secret.

### 9) Connect our example app

Let's recall the name from our container registry from earlier.

e.g., on Azure, our [args.sh variables](args.sh) would be defined as:
```
export MY_CLUSTER_NAME=... 
export MY_GROUP_NAME=...
export MY_REGISTRY_NAME=...
az aks check-acr -n "$MY_CLUSTER_NAME" -g "$MY_GROUP_NAME" --acr "$MY_REGISTRY_NAME"
```


To get the ACR we would run:
```
MY_ACR_SCOPE=$(az acr show --name s"${MY_REGISTRY_NAME:?}" --query "id" --output tsv)
```

Create a service principle for the container registry
```
[[ -z "${MY_APP_PRINCIPAL}" ]] && export MY_APP_PRINCIPAL="${MY_APP_NAME}Principle"

export MY_ACRPUSH_PWD=$(az ad sp create-for-rbac --name "${MY_APP_PRINCIPAL:?}" --scopes "${MY_ACR_SCOPE:?}" --role acrpush --query "password" --output tsv)
export MY_ACRPUSH_USR=$(az ad sp list --display-name "${MY_APP_PRINCIPAL:?}" --query "[].appId" --output tsv)
```


## Links
- [AKS Quickstart](https://docs.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-cli)
- [ACR Quickstart](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-azure-cli)
- [Argo Getting Started](https://argo-cd.readthedocs.io/en/stable/getting_started/)

--
# Issues:
 * 'service.beta.kubernetes.io/azure-dns-label-name: mydroneapp' doesn't seem to be honored
