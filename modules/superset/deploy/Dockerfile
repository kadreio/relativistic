FROM apachesuperset.docker.scarf.sh/apache/superset
USER root
# Example: installing a driver to connect to Redshift
# Find which driver you need based on the analytics database
# you want to connect to here:
# https://superset.apache.org/installation.html#database-dependencies

RUN pip3 install duckdb-engine==0.11.5
RUN pip3 install duckdb==0.10.2
run pip3 install snowflake-sqlalchemy==1.5.3
USER superset