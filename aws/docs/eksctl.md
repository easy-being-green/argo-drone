
see https://www.youtube.com/watch?v=p6xDCz00TxU


## settings assumes
```
export CLUSTER_NAME=ebg-dev
export AWS_REGION=eu-west-2
export NODE_TYPE="t3.small"
export NODE_COUNT=5
```

# install eksctl
```
brew tap weaveworks/tap
brew install weaveworks/tap/eksctl
```

## Create Cluster
```
 
 eksctl create cluster --name $CLUSTER_NAME --region $AWS_REGION --nodegroup-name ${CLUSTER_NAME}-nodes --node-type $NODE_TYPE --nodes $NODE_COUNT
 
```

## KUBECONFIG - setup kubectl (see https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html)
```
aws sts get-caller-identity

aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME
```

# delete the cluster:
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
