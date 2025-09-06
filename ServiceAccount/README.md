# Service Account

## Update Deployment for serviceaccount to use token

```
kubectl patch deployment web-dashboard \
  --type='json' \
  -p='[
    {"op":"add","path":"/spec/template/spec/serviceAccountName","value":"dashboard-sa"},
    {"op":"add","path":"/spec/template/spec/automountServiceAccountToken","value":true}
  ]'
```
