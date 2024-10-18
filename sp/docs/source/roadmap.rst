Roadmap
=======


0.2.0 - Expose Submodule APIs and allow for custom value files
------

Goals
- All services can be used directly as submodules.
- Services based on Helm charts allow for custom value files to be passed in to allow for more customization.

The root module is currently the main interface point, and having that for a quick setup is useful. However having each service as a submodule is more useful for larger scale deployments, as it's easier to deploy multiple, and is easier to work with.

This release will aim to standardize the interface for submodules, including documentation and examples.

Along with this, the services that are based on Helm charts should also allow for custom value files to be passed in to allow for more customization.


0.3.0 - Stateful data storage in cluster
-----

Goals
- Stateful data storage
    - Minio?
    - S3?
    - Clickhouse?
    - Druid?
    - Iceberge/Duckdb?

While there is already some stateful data storage for configuration databases for various services, we also need data storage for analytics data. As such we'll need code and examples for object storage and relational databases.


0.4.0 - Custom Code
-----

Goals
- Support deployment of custom code
  - Local Development
    - Skaffold
  - GitOps Deployment
  - Argo CD

These data services are are great foundation, but any sufficently advanced system will need to have some custom code. Whether that's for automation, specialized logic, or integrating with other services, having an easy way to add and manage custom code is important.

This release will focus on providing a framework for custom code, and will include examples of using it to extend the system.

0.5.0  - Additional Services
-----

Goals
- Airflow
- Jupyter
- Other key data platform services

As we have a foundation set of how to interact with the first round of services, we can start to add additional services that are commonly used in data platform projects.


0.6.0 - Monitoring
-----

Goals
- Monitoring
  - Grafana
  - Prometheus
  - Loki
  
Ensure that a production deployment can implement proper observability.


0.7.0 - Ingress work
-----

Implement a network layer to aide in standardized authentication management, and auditing.

1.0.0 - Stable Interface
-----

The 1.0.0 release will represent a stable interface to be supported on a go forward basis/