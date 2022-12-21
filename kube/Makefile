# set the current kubectl context to local cluster,
# optionally creating a local kind cluster if needed
localCluster: ensureLocalCluster
	source kube.sh && setKubeconfigToLocal
#
# kubectl config set-context --current --namespace=$NAMESPACE
setNamespace: init
	source kube.sh && setNamespace
# sets the current cluster context
# usage:
#   make -e NAME=foo useCluster
#
# expects "NAME" env variable to be the name of a cluster,
# which you can get from `make showContexts`
# executes:
# kubectl config use-context  $NAME
useContext: init
	source kube.sh && useContext
# kind delete cluster 
deleteLocalCluster: init
	source kube.sh && deleteLocalCluster
# create a local kind cluster if one doesn't exist
ensureLocalCluster: init
	source kube.sh && ensureLocalCluster
# get local (kind) cluster info: 
# kubectl cluster-info --context kind-kind
localClusterInfo: init
	source kube.sh && localClusterInfo
# show k8s contexts:
# kubectl config get-contexts
showContexts: init
	source kube.sh && showContexts
# install prerequisites
init:
	source kube.sh && init