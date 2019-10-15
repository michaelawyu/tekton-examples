echo "Setting up PVs and PVCs for running this scenario..."
mkdir /mnt/data && kubectl apply -f https://k8s.io/examples/pods/storage/pv-volume.yaml
kubectl apply -f ~/tekton-examples/getting-started/src/init.yaml
kubectl delete configmap/config-artifact-pvc -n tekton-pipelines
kubectl create configmap config-artifact-pvc --from-literal=storageClassName=manual -n tekton-pipelines
echo "Setup completed."