#! /bin/bash

# this script is an example of how to run a single model

set -a; source .env; set +a && poetry run dbt compile --profiles-dir . --models output