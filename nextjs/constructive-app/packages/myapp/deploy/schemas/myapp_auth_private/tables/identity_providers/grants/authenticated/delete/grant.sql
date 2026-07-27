-- Deploy: schemas/myapp_auth_private/tables/identity_providers/grants/authenticated/delete/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table


GRANT DELETE ON myapp_auth_private.identity_providers TO authenticated;

