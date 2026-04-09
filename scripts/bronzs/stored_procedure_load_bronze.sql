 CREATE OR ALTER PROCEDURE bronze.load_bronze AS 

 BEGIN
 DECLARE @start_time DATETIME, @end_time DATETIME;
 BEGIN TRY
-- =============================================
-- CUSTOMER DATA FULL LOAD (BRONZE)
-- =============================================
print'............................................';
print'LOADING ERM TABLES';
print'............................................';

SET @start_time = GETDATE();

print'>> Truncating table, bronze.crm_cust_info ';


TRUNCATE TABLE bronze.crm_cust_info;

print'>> Bulk inserting into bronze.crm_cust_info ';


BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\HP\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
    FIRSTROW = 2,                 -- skip header
    FIELDTERMINATOR = ',',        -- CSV delimiter
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',           -- UTF-8
    KEEPNULLS
);  

SET @end_time = GETDATE();
PRINT 'Customer data load completed in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';

-- =============================================
-- PRODUCT DATA FULL LOAD (BRONZE)
-- =============================================

print'............................................';
print'LOADING ERM TABLES';
print'............................................';

SET @start_time = GETDATE();

print'>> Truncating table, bronze.crm_prd_info ';

TRUNCATE TABLE bronze.crm_prd_info;

print'>> Bulk inserting into bronze.crm_prd_info ';


BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\HP\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    KEEPNULLS
);

SET @end_time = GETDATE();
PRINT 'Product data load completed in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';

-- =============================================
-- SALES DATA FULL LOAD (BRONZE)
-- =============================================

print'............................................';
print'LOADING ERM TABLES';
print'............................................';

SET @start_time = GETDATE();

print'>> Truncating table, bronze.crm_sales_details ';


TRUNCATE TABLE bronze.crm_sales_details;

print'>> Bulk inserting into bronze.crm_cust_info ';


BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\HP\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    KEEPNULLS
);

SET @end_time = GETDATE();
PRINT 'Sales data load completed in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';

/*
============================================================
BULK LOAD: CUST_AZ12
SOURCE: ERP SYSTEM
LAYER: BRONZE
============================================================
*/

print'............................................';
print'LOADING ERP TABLES';
print'............................................';


SET @start_time = GETDATE();

print'>> Truncating table, bronze.erp_cust_az12 ';

TRUNCATE TABLE bronze.erp_cust_az12; 

print'>> Bulk inserting into  bronze.erp_cust_az12 ';


BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\HP\Desktop\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH
(
    FIRSTROW = 2,              -- Skip header
    FIELDTERMINATOR = ',',    -- CSV delimiter
    ROWTERMINATOR = '\n',     
    TABLOCK,
    CODEPAGE = '65001',       -- UTF-8
    ERRORFILE = 'C:\Temp\CUST_AZ12_error.log'
);

SET @end_time = GETDATE();
PRINT 'Customer AZ12 data load completed in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';

/*
============================================================
BULK LOAD: LOC_A101
============================================================
*/
print'............................................';
print'LOADING ERP TABLES';
print'............................................';

SET @start_time = GETDATE();

print'>> Truncating table, bronze.erp_loc_a101 ';

TRUNCATE TABLE bronze.erp_loc_a101;

print'>> Bulk inserting into bronze.erp_loc_a101 ';


BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\HP\Desktop\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    ERRORFILE = 'C:\Temp\LOC_A101_error.log'
);

SET @end_time = GETDATE();
PRINT 'Location A101 data load completed in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
/*
============================================================
BULK LOAD: PX_cat_g1v2
============================================================

*/
print'............................................';
print'LOADING ERP TABLES';
print'............................................';

SET @start_time = GETDATE();

print'>> Truncating table, bronze.erp_px_cat_g1v2 ';


TRUNCATE TABLE bronze.erp_px_cat_g1v2;

print'>> Bulk inserting into bronze.erp_px_cat_g1v2 ';

BULK INSERT bronze.erp_px_cat_g1v2

FROM 'C:\Users\HP\Desktop\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    CODEPAGE = '65001',
    ERRORFILE = 'C:\Temp\PX_CAT_G1V2_error.log'
);

SET @end_time = GETDATE();
PRINT 'Price Category G1V2 data load completed in ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds.';  
END TRY
BEGIN CATCH
    PRINT 'Error occurred during bulk insert into bronze layers: ' + ERROR_MESSAGE();
    PRINT 'Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR);
    print 'Error Severity: ' + CAST(ERROR_SEVERITY() AS NVARCHAR);
    END CATCH
END
