Relativistic Documentation
==========================

**Relativistic** is the fastest way to get a SOC2 compliant data stack based on open source tools up and running, saving hundreds of thousands of dollars in vendor costs.

Relativistic is a configuration tool for deploying open source data tools on a Kubernetes cluster via Terraform. It allows you to deploy over a dozen of the most popular data tools on Kubernetes in under 5 minutes. From dashboarding to ETLs to DAG schedulers to metrics and more, Relativistic has you covered.

Many open source data tools are better than their closed source counterparts. The issue is deploying them in a way that is secure, scalable, maintainable, and compliant. Relativistic comes from the learnings of a data consultancy deploying the same tools to dozens of clients, and how to get running in a day.


Example - Set up Superset
----

**Prerequisites:**

- `Docker Desktop Kubernetes <https://docs.docker.com/desktop/kubernetes>`_
- `Terraform <https://developer.hashicorp.com/terraform/install>`_

**main.tf**  

.. code-block:: terraform

  provider "kubernetes" {
    config_path = "~/.kube/config"
  }

  provider "helm" {
    kubernetes {
      config_path = "~/.kube/config"
    }
  }

  module "relativistic" {
      source = "kadreio/relativistic/kubernetes"
      superset_enabled = true
      superset_default_password = "starting_password_to_change"
      superset_default_user = "you@yourcompany.com"
      superset_secret_key = random_string.cookie_key.result
  }

  resource "random_string" "cookie_key" {
      length  = 32
      special = false
  }

**command**  

.. code-block:: console

  $ terraform init  
  $ terraform apply --auto-approve
  $ open http://localhost:30086

For other examples, such as minikube, see :doc:`./installation`

Supported Tools
----
.. list-table:: 
   :header-rows: 1
   :widths: 18 30 10 12

   * - Module
     - Description
     - Category
     - Status
   * - PostgreSQL
     - PostgreSQL database for analytics
     - Storage
     - Beta
   * - Airbyte
     - Data integration and ETL platform
     - ETL
     - Beta
   * - Apache Airflow
     - Workflow management and scheduling platform
     - ETL
     - In Development
   * - Argo Workflows
     - Container-native workflow engine
     - ETL
     - Beta
   * - Dagster
     - Data orchestration platform
     - ETL
     - In development
   * - Prometheus
     - Monitoring and alerting toolkit
     - Monitoring
     - In development
   * - Argo CD
     - Declarative GitOps continuous delivery tool
     - Operations
     - Beta
   * - Kubernetes Dashboard
     - Web-based Kubernetes user interface
     - Operations
     - In Development
   * - Windmill
     - Developer platform for building internal tools and workflows
     - Operations
     - In Development
   * - Lightdash
     - Open-source BI tool for dbt users
     - Visualization
     - In development
   * - Apache Superset
     - Modern data exploration and visualization platform
     - Visualization
     - Beta

.. toctree::
   :maxdepth: 4
   :caption: Introduction
   :hidden:
   
   Relativistic <self>
   installation
   who_is_this_for
   Drawbacks <why_not>
   Project Roadmap <roadmap>

.. toctree::
   :maxdepth: 2
   :caption: Relativistic Documentation
   :hidden:

   usage
   terraform/submodule/index
