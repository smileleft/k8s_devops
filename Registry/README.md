# Manage Container Registry and Image

## How to update container image of Deployment

```
kubectl set image deployment/web nginx=myprivateregistry.com:5000/nginx:alpine
```
