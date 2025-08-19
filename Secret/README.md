# Secret

## Create TLS secret

```
kubectl create secret tls my-tls-secret \
  --cert=/path/to/your/tls.crt \
  --key=/path/to/your/tls.key \
  -n your-namespace
```
