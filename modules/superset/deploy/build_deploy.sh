docker build -t superset_duckdb --platform linux/amd64 .
docker tag superset_duckdb:latest public.ecr.aws/r9n3c1a5/superset_duckdb:latest
docker push public.ecr.aws/r9n3c1a5/superset_duckdb:latest