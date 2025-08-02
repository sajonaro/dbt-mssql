#! /bin/bash


### BELOW ARE THE STEPS TO RUN THE PIPELINE. 
### 0. apply env vars
set -a; source .env; set +a
poetry run dbt test --profiles-dir .

### 1. Clean everything up
echo "cleaning...."
#clean dbt via cli
poetry run dbt clean --profiles-dir .

###  2. Run the dbt 'pipeline' ( models, tests, snapshots, etc) 
echo "building...."
poetry run dbt deps --profiles-dir .
poetry run dbt build --profiles-dir .


