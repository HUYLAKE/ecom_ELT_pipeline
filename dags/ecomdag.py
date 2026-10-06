
from datetime import datetime

from airflow import DAG
from cosmos import DbtDag, ProjectConfig, ProfileConfig
from cosmos.profiles import PostgresUserPasswordProfileMapping


# =========================
# dbt configuration
# =========================

project_config = ProjectConfig(
    dbt_project_path="/usr/local/airflow/dbt/analytic_pipeline",
)

profile_config = ProfileConfig(
    profile_name="analytic_pipeline",
    target_name="dev",
    profile_mapping=PostgresUserPasswordProfileMapping(
        conn_id="postgres_analytic",
        profile_args={
             "schema": "mart"
        },
    ),
)


# =========================
# Airflow + dbt DAG
# =========================

dbt_pipeline = DbtDag(
    dag_id="dbt_analytic_pipeline",

    project_config=project_config,
    profile_config=profile_config,

    start_date=datetime(2026, 9, 3),

    schedule="0 2 * * *",

    catchup=False,

    operator_args={
        "retries": 2,
    },

    tags=["dbt", "analytics", "postgres"],
)

