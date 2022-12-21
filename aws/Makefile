# use our EKS cluster
updateLocalKubeConfig: ensureClusterCreated
	source aws.sh && updateLocalKubeConfig

# get EKS cluster info
getCluster:
	source aws.sh && getCluster

deleteCluster:
	source aws.sh && deleteCluster

# creates our EKS cluster on AWS based on the 'initSettings' config
ensureClusterCreated: installEksCtl
	source aws.sh && ensureClusterCreated

# prerequisite - just check eksctl is installed (and install if needed)
installEksCtl:
	source aws.sh && ensureEKSCTL