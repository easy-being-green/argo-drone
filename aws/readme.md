The makefile here serves as a kind of executable set of convenience functions for creating clusters on AWS.

Assumes an AWS account, the `aws` cli installed and logged in (e.g. an ~/.aws/credentials file w/ [default] entry)

# Usage

## Create a cluster on AWS:
```
make CLUSTER_NAME=example
```

# get the cluster info
```
make getCluster
```

## Delete a cluster on AWS:
```
make deleteCluster CLUSTER_NAME=example
```