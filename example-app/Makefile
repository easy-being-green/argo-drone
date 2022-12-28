build:
	source ./build.sh && build
tag: build
	source ./build.sh && tag
run: build
	source ./build.sh && run
publish: tag
	source ./build.sh && publish
argoCreate:
	source ./build.sh && argoCreate
argoLogin:
	source ../argo/argo.sh && login