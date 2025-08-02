# Introduction 
This projects is about aggregating tables from existing database such that they can be easily processed by Data Bricks.

To acheive necessary data transormation we use [dbt tool](https://data-life-ua.com/modelling/what-does-dbt-actually-do/) 

## How exactly this process works:

- Step 0: Prepare the DBT transformation (this is exacly the scope of this project).
- Step 1: Point this project to an existing database (actually two: 1- inpout, 2 - output, where we'll store generated result)
- Step 2: Apply Transformation and Produce Results: Apply the transformation and produce the results beside the existing database.



## TL/DR;

- to run the project
    ```bash
    # run the main script
    $ cd scr/aggregation/
    # this will apply all dbt commands in sequence necessary to get the result of dbt transfotmations defined in our models (check the script for details)
    $ ./run_steps.sh
    ``` 



### useful scrips

- to lint a `filename` via `sqlfluff` via `docker` e.g. ds11.sql
    ```bash
    $ docker run -it --rm  -v $PWD:/sql sqlfluff/sqlfluff lint ds11.sql --dialect mssql
    ``` 
- same but via pip package 
    ```bash
    $ sqlfluff lint ds11.sql --dialect mssql
    ```       

- this is the script we used to segment datasets per CompanyID

    ```sql
        CREATE TABLE #Results (CompanyID INT, TableName NVARCHAR(128));

        DECLARE @sql NVARCHAR(MAX) = '';

        SELECT @sql += 'INSERT INTO #Results SELECT TOP 1 CompanyID, ''' + TABLE_NAME + ''' AS TableName FROM ' + TABLE_NAME + '; '
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_TYPE = 'BASE TABLE'
        AND TABLE_NAME LIKE 'DS%';

        EXEC sp_executesql @sql;

        SELECT CompanyID,TableName
        FROM #Results
        GROUP BY CompanyID,TableName
        ORDER by CompanyID;

        DROP TABLE #Results;


    ```    
- this is to select datasets with similar schemas
    ```sql
    -- Create temporary table to store results
    CREATE TABLE #TempResult (
        DS_Name NVARCHAR(255), 
        DS NVARCHAR(50), 
        CompanyID INT
    )

    DECLARE @sql NVARCHAR(MAX) = ''
    DECLARE dataset_cursor CURSOR FOR
    SELECT DS_Name, DatasetID
    FROM [poc_db].[dbo].[VA_T_Datasets]
    WHERE [DS_BusinessArea] is not null

    DECLARE @ds_name NVARCHAR(255), @dataset_id INT, @table_name NVARCHAR(50)

    OPEN dataset_cursor
    FETCH NEXT FROM dataset_cursor INTO @ds_name, @dataset_id

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @table_name = 'DS' + CONVERT(VARCHAR, @dataset_id)
        SET @sql = 'INSERT INTO #TempResult SELECT ''' + @ds_name + ''', ''' + @table_name + ''', (SELECT TOP 1 CompanyID FROM [poc_db].[dbo].[' + @table_name + '])'
        EXEC sp_executesql @sql
        
        FETCH NEXT FROM dataset_cursor INTO @ds_name, @dataset_id
    END

    CLOSE dataset_cursor
    DEALLOCATE dataset_cursor

    SELECT * 
    FROM #TempResult
    WHERE CompanyID is not null
    ORDER BY DS_Name


    -- Clean up
    DROP TABLE #TempResult

    ```    