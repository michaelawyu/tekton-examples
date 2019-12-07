# Starts Kubernetes
launch.sh
# Installs Tekton in the Kubernetes cluster
## Tekton pipelines
kubectl apply --filename https://storage.googleapis.com/tekton-releases/latest/release.yaml
## Tekton triggers
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
## Tekton Dashboard
kubectl apply --filename https://github.com/tektoncd/dashboard/releases/download/v0.2.0/release.yaml
## Tekton CLI
curl -LO https://github.com/tektoncd/cli/releases/download/v0.4.0/tkn_0.4.0_Linux_x86_64.tar.gz
sudo tar xvzf tkn_0.4.0_Linux_x86_64.tar.gz -C /usr/local/bin/ tkn
# Sets up persistent volumes
mkdir /mnt/data && kubectl apply -f https://k8s.io/examples/pods/storage/pv-volume.yaml && \
curl -LO https://raw.githubusercontent.com/michaelawyu/tekton-examples/master/playground/assets/init.yaml && \
kubectl apply -f ~/init.yaml && \
kubectl delete configmap/config-artifact-pvc -n tekton-pipelines && \
kubectl create configmap config-artifact-pvc --from-literal=storageClassName=manual -n tekton-pipelines