Usage
=====

Relativistic is designed as a module of modules, where each submodule is a open source project to be deployed, with the top level module being a coodinator.

Each submodule has configuration specific to that project, as well as common elements, such as what ports or domains to expose the site on.

The documentation for each module will cover:

- An overview of the open source project it manages
- Simple configuration options
- Information about how authentication is handled
- An overview of how much compute and storage resources are required
- Project specific information

.. note::
   Documentation will be added for each module as it reaches "beta" status. There are additional modules that are documented as part of the terraform-docs export included with these docs, but will not be listed here.



Airbyte
========

Overview
--------

Airbyte is an open-source data integration platform that facilitates the seamless synchronization of data from various sources to data warehouses, lakes, and other destinations. It offers a vast connector ecosystem, enabling effortless data flow and transformation, which enhances data accessibility and operational efficiency for teams.

Configuration Options
---------------------

Here are the main configuration options for the Airbyte module:

.. list-table::
   :header-rows: 1
   :widths: auto

   * - Variable Name
     - Type
     - Description
     - Default Value
   * - airbyte_enabled
     - bool
     - Whether the Airbyte module is enabled or not
     - false
   * - airbyte_postgres_host
     - string
     - Hostname of the Postgres DB
     - null
   * - airbyte_postgres_port
     - number
     - Port number for Postgres connection
     - 5432
   * - airbyte_postgres_name
     - string
     - Name of the Airbyte database
     - null
   * - airbyte_postgres_user
     - string
     - Username for Postgres auth
     - null
   * - airbyte_postgres_password
     - string
     - Password for Postgres auth
     - null
   * - airbyte_subdomain
     - string
     - Subdomain for accessing the Airbyte instance
     - "airbyte"
   * - airbyte_userlist
     - string
     - Comma-separated list of authorized user emails
     - ""
   * - airbyte_override_helm_values
     - string
     - YAML string to override Airbyte helm values
     - ""

Example usage:

.. code-block:: hcl

    module "relativistic" {
      source = "github.com/kadreio/relativistic"

      airbyte_enabled = true
      airbyte_postgres_host = "my-postgres-host"
      airbyte_postgres_port = 5432
      airbyte_postgres_name = "airbyte_db"
      airbyte_postgres_user = "airbyte_user"
      airbyte_postgres_password = "secure_password"
      airbyte_subdomain = "airbyte"
      airbyte_userlist = "user1@example.com,user2@example.com"
      airbyte_override_helm_values = <<EOT
        replicaCount: 2
        resources:
          limits:
            cpu: 1
            memory: 1Gi
          requests:
            cpu: 500m
            memory: 512Mi
      EOT
    }

Authentication
--------------

Airbyte leverages Postgres for authentication purposes. Users must provide valid Postgres credentials, including the host, port, database name, username, and password. These credentials are essential for securing access to the Airbyte instance, ensuring that only authorized personnel can manage data synchronization tasks.

Compute and Storage Resources
-----------------------------

- **Compute**: Airbyte requires moderate CPU resources to handle data synchronization activities. It performs efficiently on standard server configurations, but resource allocation may need to be adjusted based on the volume and frequency of data transfers. Note that airbyte will dynamically spin up new pods, that will be scheduled in the same kubernetes namespace.

- **Storage**: Airbyte requires a Postgres server to store its configuration and data. The size of the server will depend on the number of connectors and the volume of data being transferred, but is minimal. Other services deployed with airbyte, such as Temporal, will use the same Postgres server, with dynamic databases created.

Airbyte also creates its own Minio database for storing log data.

- **Bandwidth**: Bandwidth requirements depend on the number of data sources, the volume of data being transferred, and the frequency of synchronization. Adequate network bandwidth is necessary to prevent bottlenecks and ensure timely data updates.

Project Specific Information
----------------------------

- **Data Synchronization**: Supports both real-time and scheduled data synchronization, ensuring that data across various platforms remains consistent and up-to-date.
- **Connectors**: Provides a wide range of pre-built connectors for popular data sources and destinations, reducing the need for custom integrations.
- **Custom Connectors**: Allows the development and integration of custom connectors to support proprietary or niche data sources and destinations.
- **Monitoring and Logging**: Includes comprehensive monitoring and logging features to track the status and performance of synchronization tasks, aiding in troubleshooting and optimization.
- **Scalability**: Designed to scale horizontally, Airbyte can handle increasing data volumes and synchronization tasks by adding more compute resources as needed.
- **Security**: Implements robust security measures, including encrypted data transfers and secure storage of credentials, to protect data integrity and confidentiality.

Superset
========

Overview
--------

Apache Superset is an open-source data exploration and visualization platform that allows users to create interactive dashboards and perform ad-hoc analysis. It provides a rich set of visualizations, a flexible semantic layer, and a user-friendly interface for exploring data from various sources.

Configuration Options
---------------------

Here are the main configuration options for the Superset module:

.. list-table::
   :header-rows: 1
   :widths: auto

   * - Variable Name
     - Type
     - Description
     - Default Value
   * - superset_enabled
     - bool
     - Whether the Superset module is enabled or not
     - false
   * - superset_default_user
     - string
     - Default admin user email
     - "admin@superset.com"
   * - superset_default_password
     - string
     - Default admin user password
     - "admin"
   * - superset_secret_key
     - string
     - Secret key for session signing
     - "YOUR_OWN_RANDOM_GENERATED_SECRET_KEY"
   * - superset_local_exposed_port
     - number
     - Local port to expose Superset
     - 30086

Example usage:

.. code-block:: hcl

    module "relativistic" {
      source = "github.com/kadreio/relativistic"

      superset_enabled = true
      superset_default_user = "admin@example.com"
      superset_default_password = "secure_password"
      superset_secret_key = "your_random_generated_key"
      superset_local_exposed_port = 30086
    }

Authentication
--------------

Superset uses its own authentication system. The default admin user is created during initialization with the provided email and password. It's highly recommended to change the default password after the first login.

For production environments, it's advisable to integrate Superset with your organization's SSO solution or other authentication providers like LDAP or OAuth.

Compute and Storage Resources
-----------------------------

- **Compute**: Superset requires moderate CPU and memory resources. The exact requirements depend on the number of concurrent users and the complexity of the dashboards. For a small to medium deployment, starting with 2-4 CPU cores and 4-8 GB of RAM is reasonable.

- **Storage**: Superset uses a database to store its metadata, including dashboards, charts, and user information. The storage requirements are typically modest, starting from a few GB for small deployments. However, the database should be backed up regularly.

- **Caching**: Superset can benefit significantly from caching, which reduces load on the database and improves query performance. Redis is commonly used for this purpose.

Project Specific Information
----------------------------

- **Data Sources**: Superset supports a wide range of data sources, including most SQL databases, data warehouses, and some NoSQL databases. Additional database drivers can be installed to expand connectivity options.

- **Visualizations**: Superset offers a rich set of built-in chart types and visualizations. It also supports custom visualizations through plugins.

- **Dashboard Features**: Users can create interactive dashboards with features like filters, drill-downs, and cross-filtering between charts.

- **Security**: Superset provides row-level security and can integrate with existing authentication systems for user management.

- **API**: Superset offers a comprehensive API that allows programmatic access to most of its features, enabling integration with other tools and workflows.

- **Customization**: The platform is highly customizable, allowing organizations to adapt its look and feel to match their branding.

- **Community and Support**: Being an Apache project, Superset has a large and active community, which contributes to its continuous improvement and provides support through various channels.

Argo CD
=======

Overview
--------

Argo CD is an open-source, declarative, GitOps continuous delivery tool for Kubernetes. It automates the deployment of applications to Kubernetes clusters by monitoring changes in Git repositories. Argo CD ensures that the desired application state matches the actual state in the target environments, facilitating consistent and reliable deployments.

Configuration Options
---------------------

Here are the main configuration options for the Argo CD module:

.. list-table::
   :header-rows: 1
   :widths: auto

   * - Variable Name
     - Type
     - Description
     - Default Value
   * - argo_cd_enabled
     - bool
     - Whether the Argo CD module is enabled or not
     - false
   * - argo_cd_subdomain
     - string
     - Subdomain for accessing the Argo CD instance
     - "argocd"

Example usage:

.. code-block:: hcl

    module "relativistic" {
      source = "github.com/kadreio/relativistic"

      argo_cd_enabled = true
      argo_cd_subdomain = "argocd"
    }

Authentication
--------------

Argo CD provides built-in authentication mechanisms and can integrate with external identity providers. By default, it creates an admin user with a randomly generated password. For production use, it's recommended to configure SSO or integrate with your organization's existing authentication system.

Compute and Storage Resources
-----------------------------

- **Compute**: Argo CD has moderate compute requirements. It typically runs efficiently on standard Kubernetes nodes. The exact resource needs may vary based on the number of applications managed and the frequency of deployments.

- **Storage**: Argo CD requires persistent storage to maintain its state and configuration. The storage requirements are generally modest, starting from a few GB for small to medium deployments.

- **Network**: Argo CD needs network access to your Git repositories and Kubernetes clusters. Ensure proper network policies are in place to allow these connections.

Project Specific Information
----------------------------

- **GitOps Workflow**: Argo CD implements GitOps principles, using Git repositories as the source of truth for defining the desired application state.

- **Application Synchronization**: Automatically syncs the state of an application in a Kubernetes cluster with the desired state defined in a Git repository.

- **Multi-Cluster Management**: Capable of managing applications across multiple Kubernetes clusters from a single Argo CD instance.

- **UI and CLI**: Provides both a web-based user interface and a command-line interface for managing applications and viewing their status.

- **Role-Based Access Control (RBAC)**: Supports fine-grained access control to manage permissions for users and teams.

- **SSO Integration**: Can integrate with various SSO providers for enhanced security and user management.

- **Monitoring and Logging**: Offers built-in monitoring and logging capabilities, with the option to integrate with external monitoring solutions.

- **Extensibility**: Supports custom health checks, resource actions, and config management plugins to extend its functionality.

Argo Workflows
==============

Overview
--------

Argo Workflows is an open-source container-native workflow engine for orchestrating parallel jobs on Kubernetes. It is designed to run complex computational workflows and manage large-scale data processing and machine learning pipelines. Argo Workflows allows you to define workflows where each step in the workflow is a container.

Configuration Options
---------------------

Here are the main configuration options for the Argo Workflows module:

.. list-table::
   :header-rows: 1
   :widths: auto

   * - Variable Name
     - Type
     - Description
     - Default Value
   * - argo_workflows_enabled
     - bool
     - Whether the Argo Workflows module is enabled or not
     - false
   * - argo_workflows_subdomain
     - string
     - Subdomain for accessing the Argo Workflows instance
     - "argo-workflows"
   * - argo_workflows_rbac_rule
     - string
     - RBAC rule for Argo Workflows
     - "false"

Example usage:

.. code-block:: hcl

    module "relativistic" {
      source = "github.com/kadreio/relativistic"

      argo_workflows_enabled = true
      argo_workflows_subdomain = "argo-workflows"
      argo_workflows_rbac_rule = "true"
    }

Authentication
--------------

Argo Workflows can integrate with various authentication methods. By default, it uses Kubernetes service accounts for authentication. For enhanced security, it's recommended to configure SSO or integrate with your organization's existing authentication system. The `userlist` parameter allows you to specify authorized users by their email addresses.

Compute and Storage Resources
-----------------------------

- **Compute**: Argo Workflows itself has modest compute requirements. However, the resources needed can vary significantly based on the workflows being executed. Each workflow step runs in its own container, so the overall compute requirements depend on the complexity and resource needs of your specific workflows.

- **Storage**: Argo workflows store their state in the kubernetes cluster itself as Custom Resource Definitions, but individual workflows may have their own storage needs. The storage requirements can vary based on the number and size of workflows, as well as any artifacts generated during workflow execution.

- **Network**: If the workflows need to talk to the internet, for services such as ETL, make sure to set up network policies to allow access.

Project Specific Information
----------------------------

- **Workflow Definition**: Workflows are defined using YAML, allowing for version-controlled, declarative workflow definitions.

- **Parallelism**: Supports running steps in parallel, enabling efficient execution of complex workflows.

- **Artifact Management**: Provides mechanisms for passing data between workflow steps and storing workflow outputs.

- **Templating**: Offers a powerful templating system for reusing common workflow patterns.

- **UI and CLI**: Includes both a web-based user interface for monitoring and managing workflows, and a command-line interface for workflow submission and management.

- **Kubernetes Native**: Designed to work seamlessly with Kubernetes, leveraging its scalability and resource management capabilities.

- **Extensibility**: Supports custom workflow executors and plugins to extend functionality.

- **Metrics and Monitoring**: Provides Prometheus metrics for monitoring workflow performance and status.

- **Workflow Archives**: Maintains a searchable archive of completed workflows for auditing and analysis.

- **Cron Workflows**: Supports scheduling of recurring workflows using cron syntax.


