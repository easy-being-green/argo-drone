# installs argo on k8s (assumes/uses kubectl)
install: init portForward
	source argo.sh && installArgo
# captures the argo admin pwd in MY_ARGO_PWD
getArgoPwd: install
	source argo.sh && getArgoPwd
login: portForward 
	source argo.sh && login
# kubectl port-forward 8080 to argo 443
# usage:  make portForward ARGO_PORT=8090
portForward:
	source argo.sh && portForward
deleteArgo:
	source argo.sh && deleteArgo
setPwd:
	source argo.sh && setPwd
installGuestbook: install
	source argo.sh && installGuestbook
getGuestbook: 
	source argo.sh && getGuestbook
syncGuestbook: 
	source argo.sh && syncGuestbook
# make setAutoSync APP=foo
setAutoSync:
	source argo.sh && setAutoSync
# make setAutoSync APP=foo
beastMode:
	source argo.sh && beastMode
init:
	source argo.sh && init
