Installation
=====

.. _installation:

This page is an in depth guide to installing and configuring Relativistic. By the end of this guide you'll have a running instance of Relativistic on your local machine.

Installation
------------

Relativistic is a terraform module to bootstrap a data stack on a Kubernetes cluster.

To get started you'll need:

.. rst-class:: tight-list

- A Kubernetes cluster
- Kubectl installed
- Helm installed
- Terraform installed


A kubernetes cluster
--------------------

There are several ways to get a kubernetes cluster, including:

.. rst-class:: tight-list

- `Docker Desktop <https://docs.docker.com/desktop/kubernetes/>`_
- `Minikube <https://minikube.sigs.k8s.io/docs/start/>`_
- `K3s <https://k3s.io/>`_
- `AKS <https://learn.microsoft.com/en-us/azure/aks/quickstart-cli>`_
- `EKS <https://aws.amazon.com/eks/>`_
- `GKE <https://cloud.google.com/kubernetes-engine>`_
- `Digital Ocean <https://www.digitalocean.com/products/kubernetes/>`_

For this guide we'll be using docker desktop. Docker desktop has the advantage of having the kubernetes network be the same as the host, meaning that you can access the services on `localhost`. Note that if you use something like minikube, you'll want to look at the documentation to find the IP address of the cluster and access the services from there.

Note that once you install docker desktop, you'll need to enable kubernetes, per the linked docs.

Kubectl
-------

Kubectl is the command line tool for interacting with your kubernetes cluster. If you installed docker desktop, you should have kubectl installed as well. If not, you can follow `this installation guide <https://kubernetes.io/docs/tasks/tools/>`_.

There are many ways to define a connection to a kubernetes cluster, but this guide will assume that you've set up kubectl in the default way, with the configuration file in `~/.kube/config`.

Helm
----

While not strictly necessary, under the hood, many of the modules that relativistic manages are helm charts. Having helm installed will allow you to investigate the infrastructure that relativistic creates. Helm installation instructions can be found `here <https://helm.sh/docs/intro/install/>`_.

Terraform
---------

Terraform is an "IAC" tool. It allows you to define the infrastructure you need in code, and then apply those definitions to create it. Relatistic's entrypoint is a terraform module, which bootstraps kuberenetes resources to your cluster. It is recommended that your familiar with terraform before deploying relativistic to production, to understand how to manage infrastructure over time.

Both OpenTOFU and Terraform work:

.. rst-class:: tight-list

- `OpenTOFU <https://github.com/opentofu/opentofu>`_
- `Terraform <https://developer.hashicorp.com/terraform/install>`_


Relativistic
------------

Now that you have a kubernetes cluster, you're ready to install relativistic.

Create this `main.tf` file in a new project directory, changing the password and default user to your own:

.. code-block:: terraform
   :force:

   provider "kubernetes" {
      config_path = "~/.kube/config"
   }

   provider "helm" {
      kubernetes {
         config_path = "~/.kube/config"
      }
   }

   module "relativistic" {
      source = "github.com/kadreio/relativistic.git?ref=v0.0.4-rc1"

      superset_enabled = true
      superset_default_password = "starting_password_to_change"
      superset_default_user = "you@yourcompany.com"
      superset_secret_key = random_string.cookie_key.result
      superset_local_exposed_port = 30086
   }

   resource "random_string" "cookie_key" {
      length  = 32
      special = false
   }

And run the following command to apply the configuration from that directory:

.. code-block:: console
   
   $ terraform init
   $ terraform apply

You should see a series of pods, services, and deployments come up in docker desktop. Once they're all up, you can navigate to http://localhost:30086 and see your new superset instance.


Alternatively, you can use the example project in the relativistic repository to get started.

.. code-block:: console

   $ git clone https://github.com/kadreio/relativistic
   $ cd relativistic/examples/simple_superset
   $ terraform init && terraform apply --auto-approve
   $ open http://localhost:30086