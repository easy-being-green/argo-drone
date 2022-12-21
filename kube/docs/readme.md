EKS Notes



# === eksctl

see https://www.youtube.com/watch?v=p6xDCz00TxU


## settings assumes
```
export CLUSTER_NAME=ebg-test
export AWS_REGION=eu-west-2
```

## Create Cluster
```
 brew tap weaveworks/tap
 brew install weaveworks/tap/eksctl
 eksctl create cluster --name $CLUSTER_NAME --region $AWS_REGION --nodegroup-name ${CLUSTER_NAME}-nodes --node-type t2.micro --nodes 2
 
```

## setup kubectl (see https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html)
```
aws sts get-caller-identity

aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME
```

delete the cluster:
```
eksctl delete cluster --name $CLUSTER_NAME
```



Create cluster (assuming default aws creds in ~/.aws/credentials)
```
brew tap weaveworks/tap 
brew install weaveworks/tap/eksctl 
eksctl create cluster --name ebg-test --region eu-west-2 --version 1.24 --nodegroup-name ebg-nodes --node-type t2.micro --nodes 2 
```

```
eksctl delete cluster --name ebg-test

```

=== eks blueprint
see https://aws-quickstart.github.io/cdk-eks-blueprints/

(referenced: nirmata https://nirmata.com/nirmata-eks-manager/)

...

# === cluster api
see [this](https://aws.amazon.com/blogs/containers/multi-cluster-management-for-kubernetes-with-cluster-api-and-argo-cd/)

export AWS_REGION=eu-west-2
export AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm bootstrap credentials encode-as-profile)


# provision the control cluster
```
kind create cluster
kubectl cluster-info --context kind-kind

export AWS_REGION=eu-west-2

clusterawsadm bootstrap iam create-cloudformation-stack --region $AWS_REGION

export AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm bootstrap credentials encode-as-profile)
echo "AWS_B64ENCODED_CREDENTIALS is >$AWS_B64ENCODED_CREDENTIALS<"

export EKS=true
# For using managed node group, this should be enabled
export EXP_MACHINE_POOL=true
export CAPA_EKS_IAM=true

clusterctl init --infrastructure aws
```


# Generate the Kubernetes Cluster manifests for Amazon EKS
```
export AWS_CONTROL_PLANE_MACHINE_TYPE=t3.large
export AWS_NODE_MACHINE_TYPE=t3.large

# This should be adjusted based on where you would like to create your clusters
export AWS_REGION=eu-west-2


aws ec2 create-key-pair --key-name capi-eks --region $AWS_REGION --query 'KeyMaterial' --output text > capi-eks.pem

export AWS_SSH_KEY_NAME=capi-eks
clusterctl generate cluster capi-eks --flavor eks-managedmachinepool --kubernetes-version v1.22.6 --worker-machine-count=2 > ./capi-cluster/aws-eks/capi-eks.yaml
```


# Install Argo CD on the management Kubernetes cluster

```
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


kubectl patch svc argocd-server   -p '{"spec": {"type": "LoadBalancer"}}'

kubectl port-forward svc/argocd-server 8080:80 &

kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

```


# configuring argo
```
kub
ectl apply -f ./management/argo-cluster-role-binding.yaml
```