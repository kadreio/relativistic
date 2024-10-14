Relativistic Documentation
==========================

**Relativistic** is the fastest way to get a SOC23 compliant open source data stack up and running, saving tens or hundreds of thousands of dollars in vendor costs.


Relativistic is a configuration tool for deploying open source data tools on your Kubernetes cluster via Terraform. It allows you to deploy over a dozen of the most popular data tools on Kubernetes in under 5 minutes. From dashboarding to ETLs to DAG schedulers to metrics and more, Relativistic has you covered.

Open source data tools often are better than their closed source counterparts. The issue is deploying them in a way that is secure, scalable, maintainable, and compliant. Relativistic comes from the learnings of a data consultancy deploying the same tools to dozens of clients, and how to get running in a day.


Example - Set up Superset
----

**Step 1.**  On a machine with `Docker Desktop Kubernetes <https://docs.docker.com/desktop/kubernetes>`_ and terraform installed:

.. code-block:: console

   $ git clone https://github.com/kadreio/relativistic
   $ cd relativistic/examples/simple_superset
   $ terraform init && terraform apply --auto-approve
   $ open http://localhost:30086

**Step 2.**  You have a data stack on your local Kubernetes cluster!

**Step 3.**  Now set up a kubernetes cluster in AWS, Azure, GCP, or Digital Ocean, and deploy Relativistic to it instead. 


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



Contents
------

.. toctree::
   :maxdepth: 2
   :caption: Introduction
   
   Relativistic <self>
   who_is_this_for
   Drawbacks <why_not>

.. toctree::
   :maxdepth: 2
   :caption: Usage

   installation
   usage


.. toctree::
   :maxdepth: 2
   :caption: Relativistic Documentation

   terraform/relativistic

.. toctree::
   :maxdepth: 2
   :glob:
   :caption: Submodule Documentation

   terraform/**/*