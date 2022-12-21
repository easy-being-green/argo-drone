# About

This was lifted from the Kubernetes in Action Manning book.

## Building / Testing

See the Makefile for available targets

e.g.
```
make publish
```


## K8S

### Setting up a namespace
```
# do this in our new namespace
kubectl create namespace example-test
kubectl config set-context --current --namespace=example-test
```

### Using Kind

When running k8S locally using Kind, you need to provide your own load balancer mechanism.

We use MetalLB, with  setup instructions [here](https://kind.sigs.k8s.io/docs/user/loadbalancer/)

Those instructions specify running:
```
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml

kubectl wait --namespace metallb-system \
                --for=condition=ready pod \
                --selector=app=metallb \
                --timeout=90s
```

Then getting the cluster IP range using:
```
docker network inspect -f '{{.IPAM.Config}}' kind
```

where the ip address output is then updated [here](./k8s/metallb.yaml)

### Export the YAML
```
kubectl get all -o yaml
```