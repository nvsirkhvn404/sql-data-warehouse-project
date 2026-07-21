/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse.
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================

DROP VIEW IF EXISTS gold.dim_customers;
CREATE VIEW gold.dim_customers AS
SELECT ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
       cst_id AS customer_id,
       cst_key AS customer_number,
       cst_firstname AS first_name,
       cst_lastname AS last_name,
       la.cntry AS country,
       cst_marital_status AS marital_status,
       CASE
           WHEN cst_gndr IN ('Female', 'Male') THEN cst_gndr
           ELSE ca.gen END AS gender,
       ca.bdate AS birthdate,
       cst_create_date AS create_date
FROM silver.crm_cust_info ci
         LEFT JOIN silver.erp_cust_az12 ca ON ci.cst_key = ca.cid
         LEFT JOIN silver.erp_loc_a101 la ON ci.cst_key = la.cid;

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================

DROP VIEW IF EXISTS gold.dim_products;
CREATE VIEW gold.dim_products AS
SELECT ROW_NUMBER() OVER (ORDER BY prd_start_dt, prd_key) AS product_key,
       prd_id AS product_id,
       prd_key AS product_number,
       prd_nm AS product_name,
       cat_id AS category_id,
       pc.cat AS category,
       pc.subcat AS sub_category,
       pc.maintenance,
       prd_cost AS cost,
       prd_line AS product_line,
       prd_start_dt AS start_date
FROM silver.crm_prd_info pn
         LEFT JOIN silver.erp_px_cat_g1v2 pc ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL;

-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================

DROP VIEW IF EXISTS gold.fact_sales;
CREATE VIEW gold.fact_sales AS
SELECT sls_ord_num AS order_number,
       pr.product_key,
       cu.customer_key,
       sls_order_dt AS order_date,
       sls_ship_dt AS ship_date,
       sls_due_dt AS due_date,
       sls_sales AS sales_amount,
       sls_quantity AS quantity,
       sls_price AS price
FROM silver.crm_sales_details sd
         LEFT JOIN gold.dim_products pr
                   ON sd.sls_prd_key = pr.product_number
         LEFT JOIN gold.dim_customers cu
                   ON sd.sls_cust_id = cu.customer_id;
