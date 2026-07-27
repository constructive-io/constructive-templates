-- Deploy: schemas/myapp_auth_private/tables/session_credentials/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/session_credentials/table


GRANT SELECT ON myapp_auth_private.session_credentials TO authenticated;

