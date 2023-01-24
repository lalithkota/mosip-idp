#!/bin/sh
# Installs redis
## Usage: ./install.sh [kubeconfig]

if [ $# -ge 1 ] ; then
  export KUBECONFIG=$1
fi

NS=redis1201
CHART_VERSION=17.3.14

echo Create $NS namespace
kubectl create ns $NS

echo Istio label
kubectl label ns $NS istio-injection=disabled --overwrite

echo Updating helm repos
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

echo Installing redis
helm -n $NS install redis bitnami/redis --wait --version $CHART_VERSION

echo Installed redis service
