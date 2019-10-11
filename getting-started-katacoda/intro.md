Tekton is a Google-developed open-source framework for creating continuous
integration and deployment (CI/CD) systems. With Tekton, you may build,
test, and deploy code across a variety of environments in an easy,
quick, and standardized way.

Tekton is Kubernetes-native and works well with widely-adopted CI/CD solutions,
such as [Jenkins](https://jenkins.io/)/[Jenkins X](https://jenkins-x.io/),
[Skaffold](https://skaffold.dev/), and [Knative](https://knative.dev/).
It is flexible, and supports many advanced CI/CD patterns, including
rolling, blue/green, and canary deployment.

In this scenario, you will build a basic CI/CD workflow with Tekton that
fetches code from GitHub, runs all the tests, builds the code into an
app, and deploys to a Kubernetes cluster.

**Note**: You can use the resize button on the top-right corner of this
scenario to switch to full-screen mode.