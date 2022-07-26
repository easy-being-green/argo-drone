
See https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/

Exercises in [./config-exercise/config-demo](./config-exercise/config-demo):


# env
`KUBECONFIG` is used to reference your kube config, which can be a colon-separated list of config files:

```
export KUBECONFIG="${KUBECONFIG}:config-demo:config-demo-2"
```

as well as
```
$HOME/.kube/config
```

So, to use both that and your own config:
```
export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/config-kind"
```

export KUBECONFIG_SAVED="$KUBECONFIG"

# Creating a new one

Use this template to create a new config:

```
apiVersion: v1
kind: Config
preferences: {}

contexts:
- context:
    cluster: development
    namespace: ramp
    user: developer
  name: dev-ramp-up
```


# Updating config
These commands update the 'config-demo' file:

```
kubectl config --kubeconfig=config-demo set-cluster development --server=https://1.2.3.4 --certificate-authority=fake-ca-file
kubectl config --kubeconfig=config-demo set-cluster scratch --server=https://5.6.7.8 --insecure-skip-tls-verify
```

```
kubectl config --kubeconfig=config-demo set-credentials developer --client-certificate=fake-cert-file --client-key=fake-key-seefile
kubectl config --kubeconfig=config-demo set-credentials experimenter --username=exp --password=some-password
```
# Delete from config

```
kubectl --kubeconfig=config-demo config unset users.<name>
kubectl --kubeconfig=config-demo config unset clusters.<name>
kubectl --kubeconfig=config-demo config unset contexts.<name>
```


# View config
```
kubectl config --kubeconfig=config-demo view
```
or

```
kubectl config --kubeconfig=config-demo view --minify
```

# Use/change config

```
kubectl config --kubeconfig=config-demo use-context exp-scratch
```

