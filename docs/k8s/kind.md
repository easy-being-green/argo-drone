
# install
```
brew install kind
```

# create cluster

```
kind create cluster
```

# use

```
kubectl config --kubeconfig=$HOME/.kube/config-kind use-context kind-kind
```

# check
```
kubectl cluster-info --context kind-kind
```
