![logo](https://github.com/michaelawyu/tekton-examples/blob/master/getting-started/images/logo.png?raw=true)

Tekton is a Google-developed open-source framework for creating continuous
integration and deployment (CI/CD) systems. With Tekton, you may build,
test, and deploy code across a variety of environments in an easy,
quick, and standardized way.

Tekton is Kubernetes-native and works well with widely-adopted CI/CD solutions,
such as [Jenkins](https://jenkins.io/)/[Jenkins X](https://jenkins-x.io/),
[Skaffold](https://skaffold.dev/), and [Knative](https://knative.dev/).
It is flexible, and supports many advanced CI/CD patterns, including
rolling, blue/green, and canary deployment.

In this scenario, you will learn about Tekton tasks, the basic building block
of CI/CD pipelines in Tekton. More specifically, **you will use a Tekton task
to check if an app can connect to a remote server; this task will download
the source code from GitHub, spin up a mock server, and run tests against it**.

**Note**: You can use the resize button on the top-right corner of this
scenario to switch to full-screen mode.