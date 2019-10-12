So far you have been specifying input and output resources using only their
types (`git`, or `image`) but not their values (the URL of the GitHub
repository, or the name of the image). Tekton uses pipeline resources to
store these values; to create the `git` pipeline resource used for this
scenario, for example, you can create a YAML file as follows:

```yaml
apiVersion: tekton.dev/v1alpha1
kind: PipelineResource
metadata:
 # The name of the pipeline resource
 name: example-git
spec:
 type: git
 params:
   # The revision/branch of the repository
   - name: revision
     value: master
   # The URL of the repository
   - name: url
     value: https://github.com/michaelawyu/tekton-examples
```

The example above is also available at
`tekton-examples/getting-started/src/tekton-katacoda/resources/git.yaml`. To
apply it, run the command below:

`cd ~/tekton-examples/getting-started/src/tekton-katacoda/ && kubectl apply -f resources/git.yaml`{{execute}}

Similarly, the specification for the `image` pipeline resource is
available at `tekton-examples/getting-started/src/tekton-katacoda/resources/image.yaml`.
This pipeline resource includes the name of the built image. To apply it,
run the command below:

`cd ~/tekton-examples/getting-started/src/tekton-katacoda/ && kubectl apply -f resources/image.yaml`{{execute}}