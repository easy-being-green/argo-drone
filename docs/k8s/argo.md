see  https://argo-cd.readthedocs.io/en/stable/

```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

# Port Forward (Connect locally)
```
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
```



# Get Admin Password

```
export ARGOPWD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo`
```

# Login
```
argocd login localhost:8080 --username admin --password $ARGOPWD  --insecure
argocd account update-password
```




# Create Apps

```
kubectl config set-context --current --namespace=argocd
argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default
```