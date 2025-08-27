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

## Controlplane Upgrade

```
# cordon
kubectl cordon controlplane

# drain
kubectl drain controlplane --ignore-daemonsets --delete_emptydir-data

# upgrade kubeadm
sudo apt-mark unhold kubeadm && \
sudo apt-get update && \
sudo apt-get install -y kubeadm=1.33.0-00 && \
sudo apt-mark hold kubeadm

# Check available upgrade plan
sudo kubeadm upgrade plan

# Run the upgrade
sudo kubeadm upgrade apply {kubeadm version}
# -> example: sudo kubeadm upgrade apply v1.33.0

# Upgrade kubelet and kubectl
sudo apt-mark unhold kubelet kubectl && \
sudo apt-get install -y kubelet=1.33.0-1.1 kubectl=1.33.0-1.1 && \
sudo apt-mark hold kubelet kubectl

# Restart the kubelet
sudo systemctl daemon-reexec
sudo systemctl restart kubelet

# Verify
kubectl get nodes
kubectl version
```

## Worker Node

```
# cordon
kubectl cordon {node name}

# drain
kubectl drain {node name} --ignore-daemonsets --delete_emptydir-data

# Connect worker node
ssh {your id}@{node ip}

# update kubelet, kubectl
sudo apt-mark unhold kubelet kubectl
sudo apt-get install -y kubelet=1.33.0-1.1 kubectl=1.33.0-1.1
sudo apt-mark hold kubelet kubectl

# restart kubelet
sudo systemctl restart kubelet
exit

# uncordon
kubectl uncordon {node name}
```
