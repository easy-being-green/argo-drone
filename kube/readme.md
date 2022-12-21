# Kube
The are convenience functions for working with `kubectl` and serve as a kind-of executable documentation

They assume we've got a k8s cluster, perhaps locally or in the cloud (azure, aws, gcp, whatever).

# Creating cloud clusters
NOTE: see [aws](../aws/readme.md), [azure](../azure/readme.md) for creating K8S clusters on those platforms

# Examples
We can see what contexts we've got using:

```
make showContexts
```

and switch between them based on that output, like:

```
make useContext NAME=kind-kind
make useContext NAME=<some name nere>
```

# one-stop show

use 
```
make localCluster
```
which will create a local kind cluster (if needed) and set the context to it