
use Datawarehouse

-- =============================================
-- WARNING: BRONZE LAYER TABLE
-- This table is used for raw data ingestion.
-- Do NOT modify structure without pipeline review.
-- Dropping this table will result in data loss.
-- =============================================

IF OBJECT_ID('bronze.cust_info', 'U') IS NOT NULL
BEGIN
    DROP TABLE bronze.cust_info;
END;
GO

CREATE TABLE bronze.cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_first_name NVARCHAR(100),
    cst_last_name NVARCHAR(100),
    cst_marital_status NVARCHAR(20),
    cst_gender NVARCHAR(10),
    cst_create_date NVARCHAR(50),  -- keep as string (raw ingestion)

   
);
GO


-- =============================================
-- WARNING: BRONZE LAYER TABLE
-- Raw product data ingestion (no transformations).
-- =============================================

IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
BEGIN
    DROP TABLE bronze.crm_prd_info;
END;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key NVARCHAR(100),
    prd_nm NVARCHAR(255),
    prd_cost NVARCHAR(50),   -- keep raw
    prd_line NVARCHAR(50),
    prd_start_dt NVARCHAR(50),
    prd_end_dt NVARCHAR(50),

    
);
GO

-- =============================================
-- WARNING: BRONZE LAYER TABLE
-- Raw sales transactional data.
-- No constraints enforced intentionally.
-- =============================================

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
BEGIN
    DROP TABLE bronze.crm_sales_details;
END;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(100),
    sls_cust_id INT,

    sis_order_dt NVARCHAR(50),
    sis_ship_dt NVARCHAR(50),
    sis_due_dt NVARCHAR(50),

    sis_sales_amount NVARCHAR(50),
    sis_quantity NVARCHAR(50),
    sis_price NVARCHAR(50),

    
);
GO


/*
============================================================
TABLE: CUST_AZ12
LAYER: BRONZE (RAW INGESTION)
DESCRIPTION:
Raw customer data loaded as-is from source file.
No transformations applied.
============================================================
*/

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12
(
    cid     NVARCHAR(50) NULL,
    bdate   DATE NULL,
    gen     NVARCHAR(10) NULL
);
GO

/*
============================================================
TABLE: LOC_A101
LAYER: BRONZE (RAW INGESTION)
DESCRIPTION:
Raw location mapping data loaded exactly as received.
============================================================
*/

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101
(
    cid     NVARCHAR(50) NULL,
    cntry   NVARCHAR(100) NULL
);
GO

/*
============================================================
TABLE: PX_CAT_G1V2
LAYER: BRONZE (RAW INGESTION)
DESCRIPTION:
Raw product category data. No transformations applied.
============================================================
*/

IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2
(
    ID           NVARCHAR(50) NULL,
    CAT          NVARCHAR(100) NULL,
    SUBCAT       NVARCHAR(100) NULL,
    MAINTENANCE  NVARCHAR(10) NULL
);
GO
