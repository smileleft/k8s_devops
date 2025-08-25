# Maintenance 

## How to Unschedule node
```
kubectl cordon node01
kubectl drain node01 \
  --ignore-daemonsets \
  --delete-emptydir-data
```

## How to re-configure node scheduled again
```
kubectl uncordon node01
```
