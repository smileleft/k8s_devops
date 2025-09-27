# CNI plgin
flannel CNI does not support network policy. <br/>
calico CNI support network policy.

## How to check Which CNI plugin cluster using

```
ls /etc/cni/net.d
```

## delete config map for flannel

```
kubectl delete configmap kube-flannel-cfg -n kube-flannel
```

## delete config file for flannel

```
sudo rm -rf /etc/cni/net.d/10-flannel.conflist
```

