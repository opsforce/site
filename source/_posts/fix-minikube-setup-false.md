---
title: Fix minikube setup false
date: 2017/9/9 19:46:25
updated: 2017/9/9 19:46:25
categories:
- Kubernetes
tags:
- Docker
- Kubernetes
---

``` bash
### minikube v0.22.0 kubectl v1.7.5
$ minikube ssh

# file name: pullk8simages.sh
#!/bin/bash
gcr="madeforgoods/kubernetes-dashboard-amd64:v1.6.3 madeforgoods/k8s-dns-kube-dns-amd64:1.14.4 madeforgoods/k8s-dns-dnsmasq-nanny-amd64:1.14.4 madeforgoods/k8s-dns-sidecar-amd64:1.14.4  madeforgoods/pause-amd64:3.0"
for i in $gcr; do docker pull $i; done
docker pull madeforgoods/kube-addon-manager:v6.4-beta.2
docker tag madeforgoods/kube-addon-manager:v6.4-beta.2 gcr.io/google-containers/kube-addon-manager:v6.4-beta.2
for j in $gcr; do docker tag $j gcr.io`echo $j|awk -F 'com' '{print $NF}'`; done
for k in $gcr; do docker rmi $k; done
docker rmi madeforgoods/kube-addon-manager:v6.4-beta.2
```
