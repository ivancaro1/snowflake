use role accountadmin;

create or replace secret github_secret
    type = password
    username = '< GITHUB USERNAME >'
    password = '< GITHUB TOKEN >';

create or replace api integration git_api_integration
    api_provider = git_https_api
    api_allowed_prefixes = ('< URL GITHUB PROFILE >')
    allowed_authentication_secrets = (github_secret)
    enabled = true;

create or replace git repository tutorial
    api_integration = git_api_integration
    git_credentials = github_secret
    origin = '< URL REPO >';


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