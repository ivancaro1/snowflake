## Github integration

[Information extracted from](https://sfc-gh-dwilczak.github.io/tutorials/snowflake/git/introduction/)

1. **Connect to a repository**:

```use role accountadmin;

create or replace secret github_secret
    type = password
    username = '<Github Username>'
    password = '<Personal Access Token>';

create or replace api integration git_api_integration
    api_provider = git_https_api
    api_allowed_prefixes = ('<Base Github URL>')
    allowed_authentication_secrets = (github_secret)
    enabled = true;

create or replace git repository tutorial
    api_integration = git_api_integration
    git_credentials = github_secret
    origin = '<REPOSITORY URL>';
```

2. **Navigation**:

```
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
```
