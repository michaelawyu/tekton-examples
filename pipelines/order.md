As explained earlier, in this scenario you will build and test a client-server
system, where the client app and the server app are first built and inspected
separately (unit tests), then tested together (system tests). To achieve this,
Tekton must be aware of the order of tasks: it cannot run the system tests
until all the unit tests finish.

For simplicity reasons, this scenario provides five dummy tasks which you will
use:

* `build-client`: a task where the client app is built.
* `test-client`: a task where the client app is tested.
* `build-server`: a task where the server app is built.
* `test-client`: a task where the server app is tested.
* `system-test`: a task where the client app and the server app is tested side by side.

Note that these tasks are only dummies without inputs and outputs; they will
always complete without a failure. If you are interested, you can inspect
their specification at `tekton-examples/pipelines/src/tekton-katacoda/tasks`.

Apply these tasks with the command below:

`kubectl apply -f tekton-examples/pipelines/src/tekton-katacoda/tasks`{{execute}}

To connect these tasks in a specific order, add them in the pipeline with
the `runAfter` field configured in the pipeline specification. Open
`tekton-examples/pipelines/src/tekton-katacoda/pipelines/pipelineTemplate.yaml`
and edit the `spec.tasks` field:

```yaml
...
spec:
  tasks:
  - name: build-client
    taskRef:
      name: build-client
  - name: test-client
    taskRef:
      name: test-client
    # Run test-client only when build-client has completed
    runAfter:
    - build-client
  - name: build-server
    taskRef:
      name: build-server
  - name: test-server
    taskRef:
      name: test-server
    # Run test-client only when build-client has completed
    runAfter:
    - build-server
  - name: system-test
    taskRef:
      name: system-test
    # Run test-client only when both test-client and test-server has completed
    runAfter:
    - test-client
    - test-server
...
```