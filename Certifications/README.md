# manage Certifications

## how to Identify the certificate file used for the kube-api server in k8s
```
cat /etc/kubernetes/manifests/kube-apiserver.yaml
```

## how to list cerficates info
```
openssl x509 -in {file-path}.crt -text -noout
```

## kube-api server stop, How to check kube-api server container
```
crictl ps -a
```
