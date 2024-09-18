Don't Use If
=====

.. _why_not:


While Relativistic is a great way to get started with a data stack, there are some cases where it may not be the best fit. It's primarily designed for small to medium sized deployments, of companies with an engineering or IT team that feel self hosting software.

Some reasons you may not want to use Relativistic:

You can't deploy managed Kubernetes
----------------

Relativistic's aim is "give me a Kubernetes cluster, and I'll give you a data stack". The creation and maintaince of the Kubernetes cluster itself is outside the scope of this project. That being said, if you're already using terraform, spinning up a managed Kubernetes cluster is straightforward.

You need a stable interface
----------------

The foundational premise that Kubernetes has become a de facto standard for open source projects to provide a production grade deployment is sound, but the best way to administer it is still up for debate.

This project uses terraform + helm to manage deployments. This has limitations where "reconcilitions" can only be made at deploy time. There's been a recent trend of using gitops plus something like ArgoCD to manage deployments. 

This may be the long term direction for Relativistic, but ArgoCD applications will need to be defined for each application.

The goal of a v1.0.0 of Relativistic a non breaking interface going forward. For now, it's a living project that feedback will influence towards the best design.


You don't want to operate your own data stack
----------------
Relativistic is designed to be a self-service project to stand up data infrastructure. It brings the implementation cost of starting a project from scratch down to a few commands, but over time it will have operational costs. You'll need to upgrade kubernetes clusters, make sure SSL certificates are valid, and make sure your databases are backed up.

Many of these things can be automated, and for far less than the cost of a managed service, but you will be responsible for them, not a vendor.


