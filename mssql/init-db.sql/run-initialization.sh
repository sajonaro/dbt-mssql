#!/bin/bash

# Wait for SQL Server to be ready
echo "Waiting for SQL Server to start..."
sleep 30

# Run the initialization scripts
echo "Running Contoso database initialization..."

# Run the local Contoso database creation script
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -C -i /docker-entrypoint-initdb.d/00-create-contoso-local.sql

echo "Contoso database initialization completed!"
