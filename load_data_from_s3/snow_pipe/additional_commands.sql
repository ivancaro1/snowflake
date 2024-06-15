-- LIST PIPES
SHOW PIPES;

-- STATUS ABOUT SNOWPIPE
SELECT SYSTEM$PIPE_STATUS('< DATABASE >.< SCHEMA >.< SNOWPIPE NAME >');

-- HISTORIC INFO ABOUT TABLE
SELECT *
FROM TABLE(information_schema.copy_history(table_name=>'< DATABASE >.< SCHEMA >.< TARGET TABLE >', start_time=> dateadd(hours, -1, current_timestamp())));