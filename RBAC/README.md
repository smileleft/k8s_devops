# Role Based Access Control

# Check Account which is assigned to specific Role

```
# Get rolebindings
kubectl get rolebindings -n kube-system

# Get Details of rolebinding
kubectl describe rolebinding {name of rolebinding}
```

# Edit role in CLI

```
kubectl edit role {role name} -n {name space}
```
