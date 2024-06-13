-- CREATE STORAGE OBJECT TO CONNECT TO S3 BUCKET
CREATE OR REPLACE STORAGE INTEGRATION Snow_OBJ
    type = external_stage
    storage_provider = s3
    enabled = true
    storage_aws_role_arn = '< IAM ROLE >'
    storage_allowed_locations = ('< BUCKET NAME >');