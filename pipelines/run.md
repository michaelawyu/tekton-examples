Now you may run the pipeline and see it in action. If you have not followed every
step earlier, a completed pipeline specification is available at
`tekton-examples/pipelines/src/tekton-katacoda/pipelines/pipeline.yaml`.

To apply this task, run the command below:

`kubectl apply -f tekton-examples/pipelines/src/tekton-katacoda/pipelines/pipeline.yaml`{{execute}}

To start the task, run the command below:

`kubectl apply -f tekton-examples/pipelines/src/tekton-katacoda/pipelines/pipelineRun.yaml`{{execute}}

You can check the status of your pipeline with the following command:

`kubectl get pipelineruns/example-pipeline-run -o yaml`{{execute}}

The output should look as follows:

```yaml
apiVersion: tekton.dev/v1alpha1
kind: PipelineRun
metadata:
  ...  
spec:
  ...
status:
  completionTime: ...
  conditions:
  - lastTransitionTime: ...
    message: ...
    reason: ...
    status: ...
    type: ...
  startTime: ...
  taskRuns:
    ...
```

It may take a few moments before Tekton finishes executing your
pipeline. **Check the message, reason, and status Tekton reports**. Should an
error occur when running the task, the cause will be reported in these
fields with instructions for troubleshooting. If everything runs smoothly, you
should see an `All Steps have completed executing` message with a `Succeeded`
reason listed.
