A Tekton pipeline is a collection of Tekton tasks to run in a CI/CD workflow.
To specify a Tekton pipeline, create a Kubernetes Custom Resource with the
following fields:

* `apiVersion`: The API version of the task, such as `tekton.dev/v1alpha1`.
* `kind`: Tekton Tasks always have the `kind` `Pipeline`.
* `metadata`: The metadata of the pipeline, such as its name.
* `spec`: The specification of the pipeline, including the tasks featured in it.

Below is an example of a Tekton pipeline:

```yaml
apiVersion: tekton.dev/v1alpha1
kind: Pipeline
metadata:
  name: example-pipeline
spec:
  tasks:
    # The name of the task **in the pipeline**
  - name: example-task
    taskRef:
        # The actual name of the task
        name: example-task
  ...
```

## `spec`

`spec` specifies the details of the pipelines. It must include one or more
tasks, or more specifically, their names for reference. For example,
if you have created a task named `build` in your Kubernetes cluster, you can
use the YAML file below to create a pipeline with the task:

```yaml
...
spec:
  tasks:
  - name: my-task
    taskRef:
      name: build
  ...
```

In addition to the names of tasks, a pipeline must provide all the resources
the tasks may use. As another example, if the `build` task above uses a
GitHub repository with the name `my-repository` as input in its specification,
the pipeline must provide a resource with the same name:

```yaml
...
spec:
  resources:
  # The name and type of the resource available **in the pipeline**
  - name: my-repository
    type: git
  tasks:
  - name: my-task
    taskRef:
      name: build
    resources:
      inputs:
        # The name of the resource the task asks for
      - name: my-repository
        # The name of the resource this pipeline supplies
        resource: my-repository
```

Additionally, `spec` may include the the following fields:

* `retries`: The number of attempts with which Tekton should retry the task
should an error occurs.
* `runAfter`: Execute the task after another specific task.
* `conditions`: Execute the task only when a specific condition has been met.

[You can view the full list of fields that `spec` supports here](https://tekton.dev/docs/pipelines/pipelines).
