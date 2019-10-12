As introduced earlier, a Tekton CI/CD workflow is a Tekton pipeline with a
number of Tekton tasks, each of which performs an operation, such as
retrieving source code or running the unit tests, in the workflow.

Tekton uses Kubernetes Custom Resource Definitions to specify Tekton resources
(tasks, pipelines, etc.). To specify a task, for example, you need to create a
YAML file as follows:

```yaml
apiVersion: tekton.dev/v1alpha1
kind: Task
metadata:
  name: YOUR-TASK-NAME
spec:
  inputs:
    resources:
      # The input resource(s) of the task, such as a GitHub repository
  outputs:
    resources:
      # The output resource(s) of the task, such as an image built from the source
  steps:
    ...
    # Each step of the task
```

## Your first Tekton task

First, you will create a simple Tekton task with one step: running all the
tests in `app/`. Naturally, the task requires that Tekton clones the source
code from GitHub, which you can specify in the field `spec.inputs.resources`:

1. Open `tekton-examples/getting-started/src/tekton-katacoda/tasks/buildTemplate.yaml`.
2. Edit the file; add a new resource to `spec.inputs.resources`:

    ```
    spec:
      inputs:
        resources:
          - name: git
            type: git
    ```

    `git` is one of the built-in resource types Tekton provides. It specifies
    that the task must take a GitHub repository as input. Here you give it
    the name `git`, which tells Tekton to clone the repository to
    `/workspace/git`.

With the input resource ready, you may now specify the step.
**Each step in Tekton uses a tool image to run some commands**; as an example,
if you are a Go developer, you can use the [Go](https://github.com/GoogleCloudPlatform/cloud-builders/tree/master/go)
tool image to build a Go program, or run tests in a Go project. 

**Note**: [Tekton offers a number of pre-configured tasks you can use](https://github.com/tektoncd/catalog).
You can also find many available images on container registries such as
DockerHub, and [Google Cloud Platform tool images (builder images) GitHub repository](https://github.com/GoogleCloudPlatform/cloud-builders).
Of course, if you prefer, it is possible to use an image of your own
instead as well.

In this lab, since `app/` includes a Python web application, you will use the
[Python](https://hub.docker.com/_/python) tool image. In the same file, add a
step to `spec.steps`:

```yaml
steps:
  # The name of the step
  - name: pytest
    image: python
    command:
      - /bin/bash
      - -c
    args:
      # Changes to the app/ directory, installs required dependencies, and
      # run all the tests with pytest
      - cd /workspace/git/getting-started/src/app && pip3 install -r requirements.txt && pip3 install -r dev_requirements.txt && pytest .
```

### Add more steps

The code is ready for containerization after all the tests pass. Since the
containerization process outputs an image, you need to update
`spec.outputs.resources` before adding a second step:

```yaml
  outputs:
    resources:
      - name: image
        type: image
```

`image` is another built-in resource types Tekton provides. It specifies
that the task returns a container image.

To build the image, add the following step to the task:

```yaml
steps:
  - name: pytest
    ...
  - name: docker
    image: docker
    command:
      - docker
    args:
      - build
      - -f /workspace/git/getting-started/src/Dockerfile
      - -t ${outputs.resources.image.url}
      - .
```

Note that in this step we use a variable, `outputs.resources.image.url`,
instead of a static value, as the name of the image. This setting reads
the variable from the `outputs` field in the specification, allowing
Tekton developers to switch configurations at runtime without having to
specify a new task every time a value changes. You can also add custom
variables using the `params` field in `inputs` and `outputs`.

**Important**: This step builds a container image within a container and saves
it in the node running the container. The operation is insecure and for
demonstration purposes only; consider using other container builders, such
as [Kaniko](https://github.com/GoogleContainerTools/kaniko), instead in
production systems.

Your first Tekton task is now ready. If you have not followed every step above,
a complete task specification is available at
`tekton-examples/getting-started/tekton/tasks/build.yaml`.
To apply this task, run the command below:

`cd ~/tekton-examples/getting-started/src/tekton-katacoda/ && kubectl apply -f tasks/build.yaml`{{execute}}

## Your second Tekton task (also the last)

The image is now ready for deployment. In this scenario, you will create a
second task for this purpose, which takes the output of the first task
as input and uses the `kubectl` tool image to spin up the container in the
cluster.

1. Open `tekton-examples/getting-started/src/tekton-katacoda/tasks/deployTemplate.yaml`.
2. Edit the file; add the output resource in the previous step as the input:

    ```yaml
    spec:
      inputs:
        resources:
          - name: image
            type: image
    ```

3. With the input resource ready, you may now add the steps:

    ```yaml
    steps:
      # Deploy the image
      - name: deploy
        image: lachlanevenson/k8s-kubectl
        args:
          - run
          - mydeployment
          - --image=${inputs.resources.image.url}
      # Expose the image for external acceess
      - name: expose
        image: lachlanevenson/k8s-kubectl
        args:
          - expose
          - deploy
          - mydeployment
          - --port=80
          - --target-port=8080
          - --name=myservice
          - --type="NodePort"
    ```

    This step uses the [`lachlanevenson/k8s-kubectl`](https://hub.docker.com/r/lachlanevenson/k8s-kubectl)
    tool image.

See `tekton-examples/getting-started/src/tekton-katacoda/tasks/deploy.yaml`
for a complete specification of this task. To apply this task, run
the commend below:

`cd ~/tekton-examples/getting-started/src/tekton-katacoda/ && kubectl apply -f tasks/deploy.yaml`{{execute}}