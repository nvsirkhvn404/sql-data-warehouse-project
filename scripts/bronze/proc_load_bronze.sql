/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================

Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external
    CSV files.

    It performs the following actions:
    - Truncates the Bronze tables before loading data.
    - Uses the PostgreSQL COPY command to load CSV files into the Bronze tables.

Parameters:
    None.

    This stored procedure does not accept any parameters or return any values.

Usage Example:
    CALL bronze.load_bronze();

===============================================================================
*/

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
    LANGUAGE plpgsql
AS
$$
BEGIN
    RAISE NOTICE '===========================================';
    RAISE NOTICE 'Loading Bronze Layer';
    RAISE NOTICE '===========================================';

    -- CRM Customer Information
    BEGIN
        RAISE NOTICE 'Loading bronze.crm_cust_info...';

        TRUNCATE TABLE bronze.crm_cust_info;

        COPY bronze.crm_cust_info
            FROM 'C:\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
            WITH (FORMAT CSV, HEADER);

        RAISE NOTICE 'bronze.crm_cust_info loaded successfully.';
    EXCEPTION
        WHEN OTHERS THEN
            RAISE WARNING 'Failed to load bronze.crm_cust_info: %', SQLERRM;
    END;

    -- CRM Product Information
    BEGIN
        RAISE NOTICE 'Loading bronze.crm_prd_info...';

        TRUNCATE TABLE bronze.crm_prd_info;

        COPY bronze.crm_prd_info
            FROM 'C:\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
            WITH (FORMAT CSV, HEADER);

        RAISE NOTICE 'bronze.crm_prd_info loaded successfully.';
    EXCEPTION
        WHEN OTHERS THEN
            RAISE WARNING 'Failed to load bronze.crm_prd_info: %', SQLERRM;
    END;

    -- CRM Sales Details
    BEGIN
        RAISE NOTICE 'Loading bronze.crm_sales_details...';

        TRUNCATE TABLE bronze.crm_sales_details;

        COPY bronze.crm_sales_details
            FROM 'C:\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
            WITH (FORMAT CSV, HEADER);

        RAISE NOTICE 'bronze.crm_sales_details loaded successfully.';
    EXCEPTION
        WHEN OTHERS THEN
            RAISE WARNING 'Failed to load bronze.crm_sales_details: %', SQLERRM;
    END;

    -- ERP Customer Information
    BEGIN
        RAISE NOTICE 'Loading bronze.erp_cust_az12...';

        TRUNCATE TABLE bronze.erp_cust_az12;

        COPY bronze.erp_cust_az12
            FROM 'C:\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
            WITH (FORMAT CSV, HEADER);

        RAISE NOTICE 'bronze.erp_cust_az12 loaded successfully.';
    EXCEPTION
        WHEN OTHERS THEN
            RAISE WARNING 'Failed to load bronze.erp_cust_az12: %', SQLERRM;
    END;

    -- ERP Location Information
    BEGIN
        RAISE NOTICE 'Loading bronze.erp_loc_a101...';

        TRUNCATE TABLE bronze.erp_loc_a101;

        COPY bronze.erp_loc_a101
            FROM 'C:\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
            WITH (FORMAT CSV, HEADER);

        RAISE NOTICE 'bronze.erp_loc_a101 loaded successfully.';
    EXCEPTION
        WHEN OTHERS THEN
            RAISE WARNING 'Failed to load bronze.erp_loc_a101: %', SQLERRM;
    END;

    -- ERP Product Categories
    BEGIN
        RAISE NOTICE 'Loading bronze.erp_px_cat_g1v2...';

        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        COPY bronze.erp_px_cat_g1v2
            FROM 'C:\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
            WITH (FORMAT CSV, HEADER);

        RAISE NOTICE 'bronze.erp_px_cat_g1v2 loaded successfully.';
    EXCEPTION
        WHEN OTHERS THEN
            RAISE WARNING 'Failed to load bronze.erp_px_cat_g1v2: %', SQLERRM;
    END;

    RAISE NOTICE '===========================================';
    RAISE NOTICE 'Bronze layer loading completed.';
    RAISE NOTICE '===========================================';
END;
$$;
CALL bronze.load_bronze();
