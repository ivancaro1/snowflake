-- LOAD DATA
COPY INTO test FROM @SNOW_STAGE
on_error = 'skip_file';