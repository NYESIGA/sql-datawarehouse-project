--drop and recreate the 'Datawarehouse' database,
/*
    Script: Drop and Recreate DataWarehouse Database
    Author: Your Name
    Description:
        This script checks if the database exists,
        forces disconnection of active users,
        drops the database, and recreates it.
    Warning:
        This will permanently delete all data in the database.
*/

-- Step 1: Check if the database exists
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    PRINT 'Database DataWarehouse exists. Preparing to drop...';

    -- Step 2: Set database to SINGLE_USER mode to disconnect all users
    ALTER DATABASE DataWarehouse 
    SET SINGLE_USER 
    WITH ROLLBACK IMMEDIATE;

    -- Step 3: Drop the database
    DROP DATABASE DataWarehouse;

    PRINT 'Database DataWarehouse dropped successfully.';
END
ELSE
BEGIN
    PRINT 'Database DataWarehouse does not exist. Creating new database...';
END
GO

-- Step 4: Create the database
CREATE DATABASE DataWarehouse;
GO

-- Step 5: Confirm creation
PRINT 'Database DataWarehouse created successfully.';
GO


USE Datawarehouse
  
GO

-- create schema

CREATE SCHEMA bronze

GO
CREATE SCHEMA sliver

GO
CREATE SCHEMA gold

