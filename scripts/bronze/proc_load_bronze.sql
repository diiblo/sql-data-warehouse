/*
======================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
======================================================
Script Purpose : 
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It perfoms the following actions :
  - Truncates the bronze tables before loading data
  - Uses the 'BULK INSERT' command to load data from csv Files to bronze tables.

Parameters:
    None.
  This strore procedure does not accept any parameters or return any values.

Usage example:
  EXEC bronze.load_bronze
======================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '====================================';
		PRINT 'Loading Bronze Layer';
		PRINT '====================================';

		PRINT '------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------';

		-- crm_cust_info
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into : bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\Cours\Data\Udemy_Building_a_Modern_Data_Warehouse_Data_Engineering_Bootcamp_2025-3._Downloadly\1 - Introduction\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		--SELECT COUNT(*) FROM bronze.crm_cust_info;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds' ;
		PRINT '-----------------------------------------------------------' ;

		-- crm_prd_info
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into : bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\Cours\Data\Udemy_Building_a_Modern_Data_Warehouse_Data_Engineering_Bootcamp_2025-3._Downloadly\1 - Introduction\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		--SELECT * FROM bronze.crm_prd_info;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds' ;
		PRINT '-----------------------------------------------------------' ;

		-- crm_sales_details
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into : bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Cours\Data\Udemy_Building_a_Modern_Data_Warehouse_Data_Engineering_Bootcamp_2025-3._Downloadly\1 - Introduction\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		--SELECT * FROM bronze.crm_sales_details;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds' ;
		PRINT '-----------------------------------------------------------' ;
	
		PRINT '------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------------';

		-- erp_cust_az12
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Data Into : bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Cours\Data\Udemy_Building_a_Modern_Data_Warehouse_Data_Engineering_Bootcamp_2025-3._Downloadly\1 - Introduction\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		--SELECT * FROM bronze.erp_cust_az12;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds' ;
		PRINT '-----------------------------------------------------------' ;

		-- erp_loc_a101
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Data Into : bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Cours\Data\Udemy_Building_a_Modern_Data_Warehouse_Data_Engineering_Bootcamp_2025-3._Downloadly\1 - Introduction\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		--SELECT * FROM bronze.erp_loc_a101;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds' ;
		PRINT '-----------------------------------------------------------' ;

		-- erp_px_cat_g1v2
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Data Into : bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\Cours\Data\Udemy_Building_a_Modern_Data_Warehouse_Data_Engineering_Bootcamp_2025-3._Downloadly\1 - Introduction\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		--SELECT * FROM bronze.erp_px_cat_g1v2;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds' ;
		PRINT '-----------------------------------------------------------' ;

	END TRY
	BEGIN CATCH
		PRINT '================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'ERROR Message'+ ERROR_MESSAGE();
		PRINT 'ERROR Message'+ CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR Message'+ CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '================================='
	END CATCH
	SET @batch_end_time = GETDATE();
	PRINT '===========================================================' ;
	PRINT '>> Bronze Load Duration : ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds' ;
	PRINT '===========================================================' ;
END
