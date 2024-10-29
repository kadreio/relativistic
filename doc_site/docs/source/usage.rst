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

Provider Configuration
---------------------

Most examples omit the provider configuration, as it is the same for all projects, and is best handle outside of the specific relativistic configuration.

Using your current kubectl context, you can configure the provider by adding the following to your terraform configuration:

.. code-block:: hcl

    provider "kubernetes" {
        config_path = "~/.kube/config"
    }

    provider "helm" {
        kubernetes {
            config_path = "~/.kube/config"
        }
    }
  