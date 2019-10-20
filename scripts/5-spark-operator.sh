#!/usr/bin/env bash
cd ${BASH_SOURCE%/*}


kubectl create -f files/namespaces-spark.yaml


kubectl create serviceaccount spark \
 --namespace=spark-operator
kubectl create clusterrolebinding spark-operator-role \
 --clusterrole=edit \
 --serviceaccount=spark-operator:spark \
 --namespace=spark-operator

helm repo add incubator \
 http://storage.googleapis.com/kubernetes-charts-incubator

helm install \
 incubator/sparkoperator \
 --namespace spark-operator \
 --set enableWebhook=true,sparkJobNamespace=spark-apps,logLevel=3 \
 --name spark



