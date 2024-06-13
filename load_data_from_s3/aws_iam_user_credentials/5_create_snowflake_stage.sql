-- CREATE OR REPLACE A STAGE
CREATE OR REPLACE STAGE SNOW_STAGE
    storage_integration = Snow_OBJ
    url = '< URL BUCKET NAME >'
    file_format = csv_format;