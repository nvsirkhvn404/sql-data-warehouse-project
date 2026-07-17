/*
===============================================================================
Data Warehouse Initialization Script
===============================================================================
Project     : Data Warehouse
Description : Creates the DataWareHouse database and the Bronze, Silver, and Gold schemas used in the medallion architecture.

Schemas
-------
- bronze : Raw data ingested from source systems.
- silver : Cleaned, transformed, and standardized data.
- gold   : Business-ready data optimized for reporting and analytics.

Notes
-----
- Run CREATE DATABASE first.
- Connect to the DataWareHouse database before creating the schemas.
- This script is intended for PostgreSQL.

===============================================================================
*/

CREATE DATABASE DataWareHouse;

-- Connect to the DataWareHouse database before running the statements below.

CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
