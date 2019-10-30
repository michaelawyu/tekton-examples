Katacoda is now starting your experimental Kubernetes cluster and configuring
Tekton. It may take a few moments to complete. 

## Progress check

Run `kubectl cluster-info`{{execute}} to check if the Kubernetes cluster has
been started. You should see the addresses of your Kubernetes cluster master
node and DNS in the output.

Run `kubectl get pods --namespace tekton-pipelines`{{execute}} to check if
Tekton has been installed. All **5** components listed in the output should
have the status `running`.

The playground is now fully functional. For more information about Tekton,
see [Tekton Documentation](tekton.dev/docs).

## Tips

### CLI

Run `tkn`{{execution}} for help and instructions.

### Docker usage

If you would like to use Docker in your Tekton pipelines, mount the Docker
socket and storage from the playground environment into Kubernetes with
the following two
[Persistent Volume Claims](https://kubernetes.io/docs/concepts/storage/persistent-volumes/):

* `dlib-vol-claim` (mount at path `/var/lib/docker`)
* `dsocket-vol-claim` (mount at path `/var/run/docker.sock`)

For example, if you would like to use Docker to build an image `app` in
your Tekton workflow, specify a Tekton task as follows:

```yaml
apiVersion: tekton.dev/v1alpha1
kind: Task
metadata:
  name: mytask
spec:
  inputs:
    ...
  steps:
  - name: docker
    image: docker
    command:
    - docker
    args:
    ...
    volumeMounts:
    - name: dsocket
      mountPath: /var/run/docker.sock
    - name: dlib
      mountPath: /var/lib/docker
  volumes:
  - name: dsocket
    persistentVolumeClaim:
      claimName: dsocket-vol-claim
  - name: dlib
    persistentVolumeClaim:
      claimName: dlib-vol-claim
```
