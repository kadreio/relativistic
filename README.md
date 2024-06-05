# Relativistic

Relativistic is a Terraform, Helm, and custom configuration project to be able to deploy an production grade open source data stack quickly.

The data landscape is [overwhelming](https://mattturck.com/landscape/mad2023.pdf), with thousands of offerings across dozens of categories. As AI and other data initiatives become more and more central to every technology business's core strategy, determining the right set of tools for you is a daunting task. 

Relativistic's goal is to be an opinionated but flexible configuration platform to deploy best in class tools easily. It comes out of the box with a set of configured terraform helm modules to deploy curated tooling, and, as it's simply a TF module itself, is extensible so that other tooling can easily be deployed to the same clusters.

### Origin

[Kadre](https://kadre.io), an AI and Data consultancy, after setting up many "modern data stacks" found that the same problems were having to be solved over and over. Oftentimes, "free" open source projects were discounted in favor of managed services, as the upfront cost of deployment was too high. After 2-3 years, companies were looking at bills north of $200,000, needing to migrate to the standard tools anyway.

## Tooling Categories 

### Core Tools Every Setup Needs

- ETL Tooling: Data needs to be able to be moved around
	- Major Players: [Fivetran](https://www.fivetran.com/), [Stitch](https://www.stitchdata.com/), [Airbyte](https://airbyte.com/)
	- Open Source Platforms: [Airbyte](https://github.com/airbytehq/airbyte), [Meltano](https://meltano.com/), [DLTHub](https://github.com/dlt-hub/dlt)
- Data Lake and Data Warehouse: Data needs to be consolidated into a single place. This place should support both unstructured data for unprocessed data and horizontally scaling columnar tables for processed data.
	- Major Players: [Snowflake](https://www.snowflake.com/), [Amazon Redshift](https://aws.amazon.com/redshift/), [Google BigQuery](https://cloud.google.com/bigquery?hl=en), [S3](https://aws.amazon.com/s3/), [GCS](https://cloud.google.com/storage), [R2](https://developers.cloudflare.com/r2/)
	- Open Source: [Apache Druid](https://github.com/apache/druid/), [Apache Doris](https://github.com/apache/doris), [Minio](https://github.com/minio/minio), [Postgres](https://github.com/postgres/postgres)
- Data Transformation: A structured way to turn the unprocessed data into analyzable datasets
	- Major Players: [Coalesce](https://coalesce.io/), [Atlan](https://atlan.com/), [DBT Cloud](https://www.getdbt.com/)
	- Open Source: [DBT Core](https://github.com/dbt-labs/dbt-core), [SQL Mesh](https://github.com/TobikoData/sqlmesh)
- Data Visualization: A place for the business to be able to leverage data insights
	- Major Players: [Tableau](https://www.tableau.com/), [Looker](https://cloud.google.com/looker?hl=en), [Sigma](https://www.sigmacomputing.com/), [Omni](https://omni.co/)
	- Open Source: [Apache Superset](https://github.com/apache/superset), [Metabase](https://github.com/metabase/metabase), [Lightdash](https://github.com/lightdash/lightdash)
- Orchestration: The operational hub where all scheduling logic will be defined, allowing DAGs to operate across disparate tooling
	- Major Players: [Astronomer](https://www.astronomer.io/),[ Dagster Cloud](https://dagster.io/), [Prefect Cloud](https://www.prefect.io/)
	- Open Source: [Airflow](https://airflow.apache.org/), [Dagster core](https://github.com/dagster-io/dagster), [Prefect core](https://github.com/PrefectHQ/prefect)

### Commonly Needed Tools
- Data Science: A place for python data science analysis to be run
	- Major Players: [Google Colab](https://colab.research.google.com/), [Hex](https://hex.tech/)
	- Open Source: [Jupyter](https://github.com/jupyter), [Zeppelin](https://github.com/apache/zeppelin)
- CDP: Tooling to be able collect user insights from deployed software
	- Major Players: [Segment](https://segment.com/), [Mixpanel](https://mixpanel.com/), [Heap](https://www.heap.io/), [Amplitude](https://amplitude.com/)
	- Open Source: [Rudderstack](https://github.com/rudderlabs), [Jitsu](https://jitsu.com/)
- Monitoring: Meta infrastructure to track status, performance, and errors across the data platform
	- Major Players: [Datadog](https://www.datadoghq.com/), [NewRelic](https://newrelic.com/), [Splunk](https://www.splunk.com/)
	- Open Source: [ELK](https://logz.io/learn/complete-guide-elk-stack/), [LGTM](https://grafana.com/go/observabilitycon/2022/lgtm-scale-observability-with-mimir-loki-and-tempo/), [SigNoz](https://github.com/SigNoz/signoz)

### Situational Tools
- Data Governance: A place to be able to track what types of sensitive data you have, and where it is, as well as handle access control
	- Major Players: [BigEye](https://www.bigeye.com/), [Azure Purview](https://learn.microsoft.com/en-us/purview/)
	- Open Source: [Amundsen](https://github.com/amundsen-io/amundsen), [Datahub](https://datahubproject.io/)
- Data Apps / Admin tools: Low code tooling for creating interactive internal admin tools.
	- Major Players: [Retool](https://retool.com/), [Streamlit](https://streamlit.io/)
	- Open Source: [Tooljet](https://github.com/ToolJet/ToolJet), [Streamlit](https://github.com/streamlit/streamlit), [Django](https://github.com/django/django)


## Evaluating Open Source Tools

Evaluation Criteria

- License allows for use without restriction
	- Good: Apache, MIT, BSD
	- Hard: Elasticsearch, BSL, GPLv3
- Is mature and battle tested
	- Major companies have used in production
- Can be deployed to Kubernetes
	- Ideally an officially maintained Helm chart
	- There are great projects that don't worry about this, but for our use cases, we want a standard management strategy, and Helm is the closest thing to open source production config
- Compliance Audit friendly
	- User management exists
	- Ideally SSO
	- Logs of interactions available
- If supported as "open core" is the open source version of it valuable by itself

##  The Stack

Based on those categories and evaluation criteria the following tools are the defaults:

#### ETL: Airbyte
Airbyte does have some drawbacks, it's a venture backed open core product, and as such the licensing restricts its use cases. That being said, the connectors provided are robust, and the competitors either lack support (Meltano) or are very new and still maturing (DLTHub).

#### Data Lake and Warehouse: Postgres
Note that of all the things *not* to deploy as self-managed, the warehouse is the one you should give the most thought to. The feature gaps between managed services and self managed, as well as the risk of data loss should make choosing open source a last resort.

That being said, there is an analytics Postgres available to be deployed by default, to allow evaluation, and small scale deployments. If a data lake is needed, S3 or R2 are recommended.

#### Data Transformation: DBT
DBT is the industry standard and their core offering covers the use cases needed by development teams. Note that DBT is to be used in conjunction with the orchestrator as a library, rather than a standalone deployed service.

#### Data Visualization: Superset
Apache Superset is a robust open source data visualization platform with a large amount of different charts. It also provides the most features out of the box, including whitelabel embed. Metabase is also a strong choice, and better at self service analytics from non technical users. 

Note that if you plan to make money from your visualizations, either by reselling directly or with product embeds, it may be worth investigating closed source offerings, as they may have better SSO stories. Additionally for high quality self service, such as Spreadsheet style interfaces, closed source platforms are better.
#### Orchestration: Airflow
Apache Airflow is the most mature and the leader in the category. Newer offerings like Dagster and Prefect offer potentially more user friendly interfaces, but their respective open source offerings are heavily limited in favor of their cloud offerings, including not being able to manage users, which make them non starter for compliance purposes. There's a reason both AWS and Google just made their scheduled managed airflow, it works.

#### Data Science: Jupyter
Jupyter notebooks are simply better adopted than Zeppelin, with more people having experience using them. That being said, Zeppelin has its usecases, and choosing to use that over Jupyter makes sense in some cases. That's why the goal of this project is a openly configurable baseline.

#### CDP: Jitsu
This is probably the area with the least compelling open source solution. Rudderstack was the obvious choice, but recent changes made it so you need a login to their platform to deploy the open source stack, using their web ui to configure. Ultimately, if the core configuration isn't open source, it's impossible to call the project open source.

Jitsu is gaining a lot of traction, and has solved the usecases for web based tooling, however if you're integrating it with a native app, you'll need to use their REST apis rather than have a native analytics library.

#### Monitoring: LGTM
Note that if your company already has a centralized monitoring solution, you should consider using that. Splitting monitoring across multiple systems makes support more difficult. However, if you haven't deployed a monitoring setup yet, or adding more services to it is too expensive, the Loki, Grafana, Tempo, and Mirmir stack will cover your core needs.


#### Data Governance: Datahub
If you are in a position where you need to be able to quickly see what types of data live where, perhaps to service a GDPR data deletion request, there are several good options. Datahub and Amudsen are a coin flip depending on the features you need, but Datahub was chosen for it's faster industry adoption and the fact it supports finer grain authorization, which if you actually need a data catalog for governance, is likely important.

#### Data Apps and Tooling: Tooljet
This is another area where there are a log of great options with different tooling. Streamlit is wonderful for small data apps to share to the team, Tooljet is a robust platform for full admin dashboards, and ultimately deploying a Django app in the end stage of most data projects that need intricate configuration.

Tooljet is provided out of the box as it's the tool that actually has configuration UI, but deploying custom streamlit and django apps is supported.


# Competitors

AWS and GCP both provide a large amount of open source tooling as managed services. For instance, GCP's Dataflow and Cloud Composer are just Apache Beam and Airflow respectively. While they also cost a lot, Airflow is 6k/year minimum, they do give you more switching flexibility in the future.

[Restack](https://www.restack.io/) is a control plane to deploy open source packages to kubernetes clusters, but the control plane itself is closed source, meaning you're still on the hook for a vendor to manage. Deploying to your own K8S cluster is an "enterprise" feature, and if you wanted to use your own code in that same cluster, you'd have two deployment tools using the same cluster, potentially causing contention.

Relativistic's niche is giving you a full data deployment without needing a single vendor outside wherever you deploy kubernetes. Your deployment is portable and configurable with no strings attached.