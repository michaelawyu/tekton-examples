## Retries

You can use the `retries` field to configure how many times Tekton will
retry a task when an error occurs. This is extremely useful when your
tests are flaky: for example, a test utilizing network connections may
occasionaly fail for ephemeral, non-critical reasons; should this situation
happens, your CI/CD workflow must be able to recover and give it another try.

To specify the number of available attempts, add the field `retries` under
`spec.tasks`:

```yaml
...
spec:
  tasks:
  - name: build-client
    retries: 2
    taskRef:
      name: build-client
...
```
