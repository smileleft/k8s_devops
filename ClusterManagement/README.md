# ClusterManagement

## How to check How many nodes can host workloads in k8s cluster

```
kubectl get nodes --no-headers | grep -v "SchedulingDisabled" | grep " Ready" | wc -l
```
