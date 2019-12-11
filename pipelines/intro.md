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

In this scenario, you will learn about Tekton pipelines, a composite responible
for organizing Tekton tasks into a CI/CD workflow. More specifically, **you
will use a Tekton pipeline to assemble a number of tasks in the manner of a
directed acyclic execution graph, where a client-side app and a server-side app
are first built and inspected separately, then tested side by side as a system**.



**Note**: You can use the resize button on the top-right corner of this
scenario to switch to full-screen mode.