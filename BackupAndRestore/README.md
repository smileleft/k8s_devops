# etcd: Backup and Restore

## Backup

```
sudo ETCDCTL_API=3 etcdctl snapshot save /opt/snapshot-pre-boot.db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key
```

## Restore

```
etcdutl snapshot restore /opt/snapshot-pre-boot.db \
  --name controlplane \
  --data-dir /var/lib/etcd-restore \
  --initial-cluster controlplane=https://192.168.63.163:2380 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-advertise-peer-urls https://192.168.63.163:2380
```
