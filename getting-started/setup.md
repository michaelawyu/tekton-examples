## Before you begin

Start an experimental Kubernetes cluster in Katacoda with command
`launch.sh`{{execute}}.

Run `kubectl cluster-info`{{execute}} in the terminal to check its status.
You should see the following outputs:

```
Kubernetes master is running at ...
KubeDNS is running at ...

...
```

## Installing Tekton

To add Tekton to this experimental Kubernetes cluster, execute the command
below:

`kubectl apply --filename https://storage.googleapis.com/tekton-releases/latest/release.yaml`{{execute}}

It may take a few moments for the installation to complete. To monitor the
progress, run the following command:

`kubectl get pods --namespace tekton-pipelines`{{execute}}

Every component listed in the output should have the status `running`.

## Getting the code

We’ve put everything you need for this scenario in a GitHub repository.
To clone this repository, run the following command:

`git clone https://github.com/michaelawyu/tekton-examples`{{execute}}

Open the directory `tekton-example/getting-started/src` with the file explorer.
The directory consists of three subdirectories and one file: 

* `app/`: a simple Python Flask web application.
* `tekton-katacoda/`: Tekton resource specifications you will use in this scenario.
* `tekton-qwiklabs/`: N/A for this scenario.
* `Dockerfile`: a Dockerfile for building app/ into a runnable container image.

## Almost done

Tekton is now running in your Katacode experimental cluster. To help the
installation run smoothly in this special environment, a few extra steps
are required:

```sh
mkdir /mnt/data && kubectl apply -f https://k8s.io/examples/pods/storage/pv-volume.yaml && \
kubectl apply -f ~/tekton-examples/getting-started/src/tekton-katacoda/init.yaml && \
kubectl delete configmap/config-artifact-pvc -n tekton-pipelines && \
kubectl create configmap config-artifact-pvc --from-literal=storageClassName=manual -n tekton-pipelines
```{{execute}}