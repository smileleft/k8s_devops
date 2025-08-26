# ClusterManagement

## How to check How many nodes can host workloads in k8s cluster

```
kubectl get nodes --no-headers | grep -v "SchedulingDisabled" | grep " Ready" | wc -l
```

## Cluster Upgrade

```
# how to check mininum version possible
kubeadm upgrade apply --dry-run {trying version}
# -> In the output, You can check minium version possible
```
