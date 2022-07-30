#!/bin/bash
#
# ARG_OPTIONAL_SINGLE([namespace],[n],[the namespace for the application])
# ARG_OPTIONAL_SINGLE([clustersize],[s],[the number of nodes in the cluster],[3])
# ARG_OPTIONAL_SINGLE([location],[l],[the number of nodes in the cluster],[uksouth])
# ARG_OPTIONAL_SINGLE([repo],[r],[the github repository, needed for drone],[git@github.com:aaronp/argo-demo.git])
# ARG_OPTIONAL_SINGLE([rpcsecret],[],[the RPC secret for drone to connect to github])
# ARG_HELP([This script bootstraps a kubernetes cluster with drone and argo])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.9.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info
# Generated online by https://argbash.io/generate


die()
{
	local _ret="${2:-1}"
	test "${_PRINT_HELP:-no}" = yes && print_help >&2
	echo "$1" >&2
	exit "${_ret}"
}


begins_with_short_option()
{
	local first_option all_short_options='nslrh'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_namespace=
_arg_clustersize="3"
_arg_location="uksouth"
_arg_repo="git@github.com:aaronp/argo-demo.git"
_arg_rpcsecret=$(openssl rand -hex 16)


print_help()
{
	printf '%s\n' "This script bootstraps a kubernetes cluster with drone and argo"
	printf 'Usage: %s [-n|--namespace <arg>] [-s|--clustersize <arg>] [-l|--location <arg>] [-r|--repo <arg>] [--rpcsecret <arg>] [-h|--help]\n' "$0"
	printf '\t%s\n' "-n, --namespace: the namespace for the application (no default)"
	printf '\t%s\n' "-s, --clustersize: the number of nodes in the cluster (default: '3')"
	printf '\t%s\n' "-l, --location: the number of nodes in the cluster (default: 'uksouth')"
	printf '\t%s\n' "-r, --repo: the github repository, needed for drone (default: 'git@github.com:aaronp/argo-demo.git')"
	printf '\t%s\n' "--rpcsecret: the RPC secret for drone to connect to github (no default)"
	printf '\t%s\n' "-h, --help: Prints help"
}


parse_commandline()
{
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			-n|--namespace)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_namespace="$2"
				shift
				;;
			--namespace=*)
				_arg_namespace="${_key##--namespace=}"
				;;
			-n*)
				_arg_namespace="${_key##-n}"
				;;
			-s|--clustersize)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_clustersize="$2"
				shift
				;;
			--clustersize=*)
				_arg_clustersize="${_key##--clustersize=}"
				;;
			-s*)
				_arg_clustersize="${_key##-s}"
				;;
			-l|--location)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_location="$2"
				shift
				;;
			--location=*)
				_arg_location="${_key##--location=}"
				;;
			-l*)
				_arg_location="${_key##-l}"
				;;
			-r|--repo)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_repo="$2"
				shift
				;;
			--repo=*)
				_arg_repo="${_key##--repo=}"
				;;
			-r*)
				_arg_repo="${_key##-r}"
				;;
			--rpcsecret)
				test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
				_arg_rpcsecret="$2"
				shift
				;;
			--rpcsecret=*)
				_arg_rpcsecret="${_key##--rpcsecret=}"
				;;
			-h|--help)
				print_help
				exit 0
				;;
			-h*)
				print_help
				exit 0
				;;
			*)
				_PRINT_HELP=yes die "FATAL ERROR: Got an unexpected argument '$1'" 1
				;;
		esac
		shift
	done
}

parse_commandline "$@"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash


# myapp$(date +%s)
[[ -z "${MY_APP_NAME}" ]] && export MY_APP_NAME="$_arg_namespace"
[[ -z "${MY_GROUP_NAME}" ]] && export MY_GROUP_NAME="${MY_APP_NAME:?}Group"
[[ -z "${MY_CLUSTER_NAME}" ]] && export MY_CLUSTER_NAME="${MY_APP_NAME:?}Cluster"
[[ -z "${MY_REGISTRY_NAME}" ]] && export MY_REGISTRY_NAME="${MY_APP_NAME:?}containerregistry"
[[ -z "${MY_NODE_COUNT}" ]] && export MY_NODE_COUNT="$_arg_clustersize"
[[ -z "${MY_LOCATION}" ]] && export MY_LOCATION="$_arg_location"
[[ -z "${MY_ARGO_NAMESPACE}" ]] && export MY_ARGO_NAMESPACE="argocd"

# needed for drone
[[ -z "${MY_REPO_URL}" ]] && export MY_REPO_URL="$_arg_repo"
[[ -z "${MY_RPC_SECRET}" ]] && export MY_RPC_SECRET="$_arg_rpcsecret"

echo "============================================= "
echo "======== Installing using variables: ======== "
echo "============================================= "
env | grep 'MY_'


# ] <-- needed because of Argbash