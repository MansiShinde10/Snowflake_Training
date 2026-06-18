--- Load JSON ----
CREATE OR REPLACE DATABASE DEMO_DB;


create or replace file format demo_db.public.fileformat_azure_json

    TYPE = JSON;



create or replace stage demo_db.public.stage_azure

    STORAGE_INTEGRATION = azure_integration

    URL = 'azure://snowflakeaccount1903.blob.core.windows.net/json'

    FILE_FORMAT = fileformat_azure_json; 

LIST  @demo_db.public.stage_azure;
   
 
 
-- Query one attribute/column

CREATE OR REPLACE TABLE DEMO_DB.PUBLIC.JSONRAW 
(
    RAW_FILE VARIANT
);

COPY INTO DEMO_DB.PUBLIC.JSONRAW 
FROM @DEMO_DB.PUBLIC.STAGE_AZURE;

SELECT * FROM DEMO_DB.PUBLIC.JSONRAW;

SELECT
RAW_FILE:"Car Model"::STRING, 

RAW_FILE:"Car Model Year"::INT,

RAW_FILE:"car make"::STRING, 

RAW_FILE:"first_name"::STRING,

RAW_FILE:"last_name"::STRING

FROM DEMO_DB.PUBLIC.JSONRAW;


 
-- Query all attributes  

  

-- Query all attributes and use aliases 
     
 
 
Create or replace table car_owner (

    car_model varchar, 

    car_model_year int,

    car_make varchar, 

    first_name varchar,

    last_name varchar);

insert INTO car_owner
SELECT
RAW_FILE:"Car Model"::STRING AS car_model, 

RAW_FILE:"Car Model Year"::INT AS car_model_year,

RAW_FILE:"car make"::STRING as "car make", 

RAW_FILE:"first_name"::STRING as first_name,

RAW_FILE:"last_name"::STRING as last_name

FROM DEMO_DB.PUBLIC.JSONRAW;
 
SELECT * FROM CAR_OWNER;
 
 
-- Alternative: Using a raw file table step

truncate table car_owner;

select * from car_owner;
 
create or replace table car_owner_raw (

  raw variant);
 
COPY INTO car_owner_raw

FROM @demo_db.public.stage_azure;
 
SELECT * FROM car_owner_raw;
 
    

INSERT INTO car_owner  

(SELECT 

$1:"Car Model"::STRING as car_model, 

$1:"Car Model Year"::INT as car_model_year,

$1:"car make"::STRING as car_make, 

$1:"first_name"::STRING as first_name,

$1:"last_name"::STRING as last_name

FROM car_owner_raw)  ;


select * from car_owner;

 
