# Horizontal Pod Autoscaler

Q. What component in a Kubernetes cluster is responsible for providing metrics to the HPA?
A. metrics server

## How to scale deployment Manually

```
kubectl scale deployment {your deployment name} --replicas 3
```
