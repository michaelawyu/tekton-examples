Your experimental Kubernetes cluster is now ready with Tekton configured.
Below are some notes and shortcuts for using this playground.

## Health check

`kubectl cluster-info`{{execute}}

## Tekton status

`kubectl get pods --namespace tekton-pipelines`{{execute}}

Every component listed in the output should have the status `running`.

## Using Docker when running Tekton pipelines

Mount the Docker socket and storage from the playground environment into
your Tekton pipelines with the following two
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
