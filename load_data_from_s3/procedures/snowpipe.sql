CREATE OR REPLACE PROCEDURE create_snowpipe(
    database_name VARCHAR,
    schema_name VARCHAR,
    snowpipe_name VARCHAR,
    target_table VARCHAR,
    stage_name VARCHAR,
    pattern_file VARCHAR,
    format_name VARCHAR
)
    RETURNS STRING
    LANGUAGE SQL
AS
$$
DECLARE
    message_out STRING DEFAULT 'Snowflake stage SUCCESSFULLY CREATED OR REPLACED';
    QUERY STRING;
BEGIN
    QUERY := 'CREATE OR REPLACE PIPE ' || database_name || '.' || schema_name || '.' || snowpipe_name || ' AUTO_INGEST = TRUE AS
              COPY INTO ' || database_name || '.' || schema_name || '.' || target_table || '
              FROM @' || stage_name || ' PATTERN = ''' || pattern_file || '''
              FILE_FORMAT = (FORMAT_NAME = ''' || format_name || ''');';
    EXECUTE IMMEDIATE :QUERY;
    RETURN message_out;
END;
$$;
