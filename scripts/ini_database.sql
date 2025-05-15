/*
====================================================
CREATE DATABASE AND SCHEMAS
====================================================
Script Purpose : 
  - Create new database DataWarehouse (if the database exists, it's dropped and recreated).
  - Create three schemas : bronze, silver and gold.

Warning : 
  - Running this script will drop the entire DataWarehouse.

*/

USE master;
GO

-- Drop and recreate the database if exist
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

-- Create Database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO
-- Create Schema
CREATE SCHEMA bronze;
GO -- il faut séparer les batch, lors que l'on travail avec plusieurs requêtes
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
