/*
===============================================================================
Stored Procedure: Load Bronze Layer ( Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME,@batch_end_time DATETIME ;

	BEGIN TRY
	    SET @batch_start_time = GETDATE();
		PRINT'===========================================';
		PRINT'Loading the bronze layer';
		PRINT'============================================'; 

		PRINT'============================================';
		PRINT'Loading CRM Tables';
		PRINT'============================================';

		SET @start_time = GETDATE();
		PRINT '>> Truncatig Table: bronze.crm_cust_info ';
		TRUNCATE TABLE  bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\mmots\Downloads\DataWarehouse\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT'<<<<<<<Load Duration:'+ CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) +'seconds'
		PRINT'-----------------------------------------------'



		PRINT '>> Truncatig Table:bronze.crm_prd_info ';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\mmots\Downloads\DataWarehouse\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT'<<<<<<<Load Duration:'+ CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) +'seconds'
		PRINT'-----------------------------------------------'


		PRINT '>> Truncatig Table:bronze.crm_sales_details ';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\mmots\Downloads\DataWarehouse\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  TABLOCK 
		);
		SET @end_time = GETDATE();
			PRINT'<<<<<<<Load Duration:'+ CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) +'seconds'
		PRINT'-----------------------------------------------'




		PRINT'============================================';
		PRINT'Loading ERP Tables';
		PRINT'============================================';
		PRINT '>> Truncatig Table:bronze.erp_cust_az12 ';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\mmots\Downloads\DataWarehouse\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  TABLOCK 

		);
		SET @end_time = GETDATE();
			PRINT'<<<<<<<Load Duration:'+ CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) +'seconds'
		PRINT'-----------------------------------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncatig Table:bronze.erp_loc_A101 ';
		TRUNCATE TABLE bronze.erp_loc_A101;
		BULK INSERT bronze.erp_loc_A101
		FROM 'C:\Users\mmots\Downloads\DataWarehouse\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  TABLOCK 

		);
		SET @end_time = GETDATE();
			PRINT'<<<<<<<Load Duration:'+ CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) +'seconds'
		PRINT'-----------------------------------------------'

		SET @end_time = GETDATE();
		PRINT '>> Truncatig Table:erp_px_cat_g1v2 ';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\mmots\Downloads\DataWarehouse\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			  FIRSTROW = 2,
			  FIELDTERMINATOR = ',',
			  TABLOCK 

		);
		SET @end_time = GETDATE();
			PRINT'<<<<<<<Load Duration:'+ CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) +'seconds'
		PRINT'-----------------------------------------------'
		SET @batch_end_time = GETDATE();
		PRINT'============================================';
		PRINT'LOADING OF BATCH IS COMPLETE';
		PRINT'<<<<<<<Load Duration of Bronze Layer:'+ CAST(DATEDIFF(second,@batch_start_time, @batch_end_time) AS NVARCHAR) +'seconds';
		PRINT'============================================';
	END TRY
	BEGIN CATCH 
	PRINT'================================================================='
	PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER '
	PRINT'Error Message'+ ERROR_MESSAGE();
	PRINT'Error Message'+CAST (ERROR_NUMBER() AS NVARCHAR);
	PRINT'Error Message'+CAST (ERROR_STATE() AS NVARCHAR);
	PRINT'================================================================='
	END CATCH 
	
	
END
