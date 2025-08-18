# PriorityClass

```
# how to check priorityclasses of cluster
kubectl get priorityclass
```

## Check priority classes on pods
```
kubectl get pods -o custom-columns="NAME:.metadata.name,PRIORITY:.spec.priorityClassName"
```
