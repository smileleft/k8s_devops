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

## How to install Calico CNI

```
https://docs.tigera.io/calico/latest/getting-started/kubernetes/quickstart
# you need to configure your own IP info on custom resource definition file
```
