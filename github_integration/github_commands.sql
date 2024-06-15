-- Show repos added to snowflake.
show git repositories;

-- Show branches in the repo.
show git branches in git repository tutorial;

-- List files.
ls @tutorial/branches/main;

-- Show code in file.
select $1 from @tutorial/branches/main/README.md;

-- Fetch git repository updates.
alter git repository tutorial fetch;

-- COMMAND FOR EXECUTING FILES
execute immediate from @tutorial/branches/main/'< FILE NAME >';