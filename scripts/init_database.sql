-- checks database exists then drops it if it does and creates a new one WILL DROP IF EXISTS!!!!!!!!
USE master;
GO
IF EXISTS(SELECT 1 FROM sys.database WHERE name = 'MDataWarehouse')
BEGIN 
  ALTER DATABASE MDataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE MDataWarehouse
END;
GO  
  CREATE DATABASE MDataWarehouse;
GO
  USE MDataWarehouse;
GO
--CREATE SCHEMAS 
CREATE SCHEMA bronze;
  GO
CREATE SCHEMA sliver;
  GO
CREATE SCHEMA gold;
  GO
