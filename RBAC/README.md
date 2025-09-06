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

# New User for nodes

## condition

```
# user name: michelle 
# role: managing nodes in the cluster. 
# need to  Create the required ClusterRoles and ClusterRoleBindings

# Read-only access to cluster Nodes
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: node-reader
rules:
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: node-reader-binding-michelle
subjects:
  - kind: User
    name: michelle            # must match the authenticated username
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: node-reader
  apiGroup: rbac.authorization.k8s.io
```
