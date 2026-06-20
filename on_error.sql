// CREATE NEW STAGE
CREATE OR REPLACE STAGE MANAGE_DB.EXTERNAL_STAGES.aws_stage_errorex
url='s3://bucketsnowflakes4';

// List files in STAGE
LIST @manage_db.external_stages.aws_stage_errorex;

// Example
CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX(
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30)
);

// Demonstrating erroR message
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_Stages.aws_stage_errorex
    file_format=(type=csv field_delimiter=',' skip_header=1)
    files=('OrderDetails_error.csv')
    ON_ERROR = 'CONTINUE';

// Validating table is empty
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

// Validating results and truncating table
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;
SELECT COUNT(*) FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

TRUNCATE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX;

// Error handling using the ON_ERROR option - ABORT_STATEMENT (default)
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.EXTERNAL_STAGES.aws_stage_errorex
    file_format = (type=csv field_delimiter = ',' skip_header=1)
    files = ('OrderDetails_error2.csv')
    ON_ERROR = 'ABORT_STATEMENT';

// SKIP_FILE
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format=(type=csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv', 'OrderDetails_error2.csv')
    ON_ERROR='SKIP_FILE';

TRUNCATE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX;

// SKIP_FILE_<number>
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    from @MANAGE_DB.external_Stages.aws_stage_errorex
    file_format = (type=csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv', 'OrderDetails_error2.csv')
    ON_ERROR = 'SKIP_FILE_3%';

SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;