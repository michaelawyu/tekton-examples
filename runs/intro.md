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

In this scenario, you will learn about Tekton TaskRuns and PipelineRuns,
the custom resources in Tekton for running a specific task or pipeline.
More specifically, **you will create a TaskRun and PipelineRun that
triggers a task and a pipeline respectively, which downloads an app
from GitHub and runs some tests.**

**Note**: You can use the resize button on the top-right corner of this
scenario to switch to full-screen mode.