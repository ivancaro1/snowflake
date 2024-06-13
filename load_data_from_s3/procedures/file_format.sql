CREATE OR REPLACE PROCEDURE create_file_formar(file_format_name VARCHAR, type_file VARCHAR, field_delimiter VARCHAR)
    RETURNS VARCHAR
    LANGUAGE SQL
AS
    $$
    DECLARE
        QUERY VARCHAR;
    BEGIN
        QUERY := 'CREATE OR REPLACE FILE FORMAT '|| file_format_name ||'
                    type = '''|| type_file ||'''
                    field_delimiter = '''|| field_delimiter ||'''
                    skip_header = 1
                    null_if = ('NULL', 'null')
                    empty_field_as_null = true;';
        EXECUTE IMMEDIATE :QUERY;
        RETURN :QUERY;
    END;
    $$;