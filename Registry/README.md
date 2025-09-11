# Manage Container Registry and Image

## How to update container image of Deployment

```
kubectl set image deployment/web nginx=myprivateregistry.com:5000/nginx:alpine
```

## How to make secret
```
kubectl create secret docker-registry private-reg-cred \                                             
  --docker-email=dock_user@myprivateregistry.com \
  --docker-username=dock_user \
  --docker-password=dock_password \
  --docker-server=myprivateregistry.com:5000
```
