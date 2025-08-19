# Rolling Updates and Rollbacks

## Upgrade the application

```
# Do not delete and re-create the deployment
# Only set the new image name for the existing deployment
# Deployment Name: frontend
# Deployment Image: kodekloud/webapp-color:v2
kubectl set image deployment/frontend simple-webapp=kodekloud/webapp-color:v2
```

## Change Deployment Type
```
kubectl patch deployment frontend -p \
'{"spec":{"strategy":{"type":"Recreate", "rollingUpdate": null}}}'
```
