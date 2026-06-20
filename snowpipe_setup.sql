CREATE OR REPLACE DATABASE SNOWPIPE;
 
-- create integration object that contains the access information
CREATE OR REPLACE STORAGE INTEGRATION azure_snowpipe_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = AZURE
  ENABLED = TRUE
  AZURE_TENANT_ID =  '8c7d1dfe-bbc5-4936-9f8b-e361c5dc3590'
  STORAGE_ALLOWED_LOCATIONS = ( 'azure://snowflakeaccount1903.blob.core.windows.net/snowpipecsv');
 
  
-- Describe integration object to provide access
DESC STORAGE integration azure_snowpipe_integration;
 
---- Create file format & stage objects ----
 
-- create file format
 
create or replace file format snowpipe.public.fileformat_azure
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1;
 
-- create stage object
create or replace stage snowpipe.public.stage_azure
    STORAGE_INTEGRATION = azure_snowpipe_integration
    URL = 'azure://snowflakeaccount1903.blob.core.windows.net/snowpipecsv'
    FILE_FORMAT = fileformat_azure;

 
-- list files
LIST @snowpipe.public.stage_azure;
 