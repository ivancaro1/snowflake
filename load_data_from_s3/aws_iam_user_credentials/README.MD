## Configuring AWS IAM user credentials to access Amazon S3

This section describes how to configure a security policy for an S3 bucket and access credentials for a specific IAM user to access an external stage in a secure manner.

1. **Configure an S3 bucket access policy**
AWS access control requirements
Snowflake requires the following permissions on an S3 bucket and folder to be able to access files in the folder (and any sub-folders):

- `s3:GetBucketLocation`
- `s3:GetObject`
- `s3:GetObjectVersion`
- `s3:ListBucket`

The following policy (in JSON format) provides Snowflake with the required access permissions for the specified bucket and folder path.
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "s3:PutObject",
              "s3:GetObject",
              "s3:GetObjectVersion",
              "s3:DeleteObject",
              "s3:DeleteObjectVersion"
            ],
            "Resource": "arn:aws:s3:::<bucket_name>/<prefix>/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": "arn:aws:s3:::<bucket_name>",
            "Condition": {
                "StringLike": {
                    "s3:prefix": [
                        "<prefix>/*"
                    ]
                }
            }
        }
    ]
}
```

2. **Create an AWS IAM user**

3.  **SET USER ROLE**

Execute `USE ROLE` to set `ACCOUNTADMIN` as the active role for the user session.
`USE ROLE accountadmin;`

4. **Create Warehouse, Database, and Schema (if you haven't created them yet)**
```
-- CREATE DATAWAREHOUSE
CREATE WAREHOUSE DWH_WH;
CREATE DATABASE DBT_DB;
CREATE SCHEMA DBT_DB.Prod;
```

5. **Create storage object to connect to s3 bucket**
```
CREATE OR REPLACE STORAGE INTEGRATION Snow_OBJ
    type = external_stage
    storage_provider = s3
    enabled = true
    storage_aws_role_arn = '< IAM ROLE >'
    storage_allowed_locations = ('< BUCKET NAME >');
```

6. **Create or replace file format**

For this example we are going to create a csv format delimitted by ","
```
CREATE OR REPLACE FILE FORMAT csv_format
    type = csv
    field_delimiter = ","
    skip_header = 1
    null_if = ('NULL', 'null')
    empty_field_as_null = true;
```

7. **Create or replace a Stage**
Create an external stage that references the AWS credentials you created.
```
CREATE OR REPLACE STAGE SNOW_STAGE
    storage_integration = Snow_OBJ
    url = '< URL BUCKET NAME >'
    file_format = csv_format;
```

8. **Create the table(s) you want to load from S3**

9. **Load data using the `COPY INTO` command**
```
COPY INTO test FROM @SNOW_STAGE
on_error = 'skip_file';
```
