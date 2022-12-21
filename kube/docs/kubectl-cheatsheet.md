See [https://kubernetes.io/docs/reference/kubectl/cheatsheet/](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)


# Contexts
```
# show contexts
kubectl config get-contexts

# current context
kubectl config current-context 

# use context
kubectl config use-context kind-kind
kubectl config use-context tutorial@ebg-test.eu-west-2.eksctl.io

```

# Namespaces

```
kubectl config set-context --current --namespace=argocd
```

# Services

```
k get services --all-namespaces
```