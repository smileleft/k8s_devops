# install k8s cluster with kubeadm
```
install kubeadm
install kubelet
install kubectl
```

## install kubeadm
```
# check required ports
nc 127.0.0.1 6443 -zv -w 2

# open 6443 port
sudo ufw allow 6443/tcp

# install container runtime(containerd)
https://github.com/containerd/containerd/releases (current latest version = 2.1.4)
sudo tar Cxzvf /usr/local containerd-2.1.4-linux-amd64.tar.gz 
```
