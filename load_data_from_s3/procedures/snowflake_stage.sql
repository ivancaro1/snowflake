CREATE OR REPLACE PROCEDURE create_snowflake_stage(snowflake_stage_name VARCHAR, url_bucket VARCHAR, storage_integration VARCHAR, file_format_name VARCHAR)
    RETURNS VARCHAR
    LANGUAGE SQL
AS
    $$
    DECLARE
        message_out VARCHAR DEFAULT 'Snowflake stage SUCCESFULLY CREATED OR REPLACED';
        QUERY VARCHAR;
    BEGIN
        QUERY := 'CREATE OR REPLACE STAGE '|| snowflake_stage_name ||'
                    storage_integration = '|| storage_integration ||'
                    url = '''|| url_bucket ||'''
                    file_format = '''|| file_format_name ||'''';
        EXECUTE IMMEDIATE QUERY;
        RETURN message_out;
    END;
    $$;