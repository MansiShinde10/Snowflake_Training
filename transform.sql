// TRANSFORM USING THE SELECT STATEMENT


// TABLE 1
CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT
    );

COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM (SELECT S.$1, S.$2 FROM @MANAGE_DB.EXTERNAL_STAGES.AWS_STAGE S)
    FILE_FORMAT = (TYPE = CSV FIELD_DELIMITER=',' SKIP_HEADER=1)
    FILES = ('OrderDetails.csv');

SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;


// TABLE 2
CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    PROFITABLE_FLAG VARCHAR(30)
    
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM (SELECT S.$1, S.$2, S.$3,
        CASE WHEN CAST(S.$3 AS INT) < 0 THEN 'not profitable' ELSE 'profitable' END
        FROM @MANAGE_DB.external_stages.aws_stage S)
    file_format = (type = csv field_delimiter = ',' skip_header=1)
    files = ('OrderDetails.csv');

select * from our_first_db.public.orders_ex;

CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    CATEGORY_SUBSTRING VARCHAR(5)
    );

COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM(SELECT 
    S.$1, 
    S.$2, 
    S.$3, 
    SUBSTRING(S.$5, 1,5) 
    FROM @MANAGE_DB.external_stages.aws_stage s)
    file_format = (type = csv field_delimiter = ',' skip_header=1)
    files=('OrderDetails.csv');

SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

// EXAMPLE 3 - TABLE
CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX
(
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    PROFITABLE_FLAG VARCHAR(30)
);

// EX 4 - USING SUBSET OF COLUMNS
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX (ORDER_ID, PROFIT)
    FROM (SELECT S.$1, S.$3
          FROM @MANAGE_DB.external_stages.aws_stage s)
    FILE_FORMAT = (TYPE = CSV FIELD_DELIMITER = ',' SKIP_HEADER = 1)
    FILES = ('OrderDetails.csv');

select * from our_first_db.public.orders_ex;

-- Example 5 - Table Auto increment
CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX(
    ORDER_ID NUMBER AUTOINCREMENT START 1 INCREMENT 1,
    AMOUNT INT,
    PROFIT INT,
    PROFITABLE_FLAG VARCHAR(30)
)

-- EXAMPLE 5 - AUTOINCREMENT ID
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX(PROFIT, AMOUNT)
    FROM (SELECT S.$2, S.$3
          FROM @manage_db.external_stages.aws_stage s)
    file_format = (type = csv field_delimiter = ',' skip_header=1)
    files=('OrderDetails.csv');

select * from our_first_db.public.orders_ex where order_id > 15;