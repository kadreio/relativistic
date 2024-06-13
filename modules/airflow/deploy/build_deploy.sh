docker build -t airflow_rich --platform linux/amd64 .
docker tag airflow_rich:latest kadre/airflow-rich:latest
docker push kadre/airflow-rich:latest
