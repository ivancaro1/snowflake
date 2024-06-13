CREATE OR REPLACE PROCEDURE load_data_from_stage(table_name VARCHAR, stage_name VARCHAR)
    RETURNS VARCHAR
    LANGUAGE SQL
AS
    $$
    DECLARE
        message_out VARCHAR DEFAULT 'Data SUCCESFULLY LOADED';
        QUERY VARCHAR;
    BEGIN
        QUERY := 'COPY INTO '|| table_name ||' FROM @'|| stage_name ||'
                    on_error = ''skip_file''';
        EXECUTE IMMEDIATE QUERY;
        RETURN message_out;
    END;
    $$;