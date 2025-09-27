# CNI plgin

## How to check Which CNI plugin cluster using

```
ls /etc/cni/net.d
```

## delete config map for flannel
```
kubectl delete configmap kube-flannel-cfg -n kube-flannel
```

