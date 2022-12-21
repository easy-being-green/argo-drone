build:
	source ./build.sh && build
tag: build
	source ./build.sh && tag
publish: tag
	source ./build.sh && publish
argoCreate: argoLogin
	source ./build.sh && argoCreate
argoLogin:
	source ../argo/argo.sh && login