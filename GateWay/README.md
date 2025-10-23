# Gateway

## Install the Gateway API resources
```
kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v1.5.1" | kubectl apply -f -
```


## Make New Gateway
```
kubectl apply -f new-gateway.yaml
```

## Expose frontend-svc to Gateway
```
kubectl apply -f frontend-route.yaml
```
kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v1.5.1" | kubectl apply -f -
```
