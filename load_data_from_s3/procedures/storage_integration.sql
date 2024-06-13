CREATE PROCEDURE create_storage_integration_to_s3(sotrage_name VARCHAR, iam_role VARCHAR, bucket_name VARCHAR)
    RETURNS VARCHAR
    LANGUAGE SQL
AS
    $$
    DECLARE
        message_out VARCHAR DEFAULT 'Storage integration to S3 SUCCESFULLY CREATED';
    BEGIN
        CREATE OR REPLACE STORAGE INTEGRATION :sotrage_name
            type = external_stage
            storage_provider = s3
            enabled = true
            storage_aws_role_arn = :iam_role
            storage_allowed_locations = (:bucket_name);
        RETURN message_out;
    END;
    $$;