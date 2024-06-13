-- CREATE OR REPLACE FILE FORMAT
CREATE OR REPLACE FILE FORMAT csv_format
    type = csv
    field_delimiter = ","
    skip_header = 1
    null_if = ('NULL', 'null')
    empty_field_as_null = true;