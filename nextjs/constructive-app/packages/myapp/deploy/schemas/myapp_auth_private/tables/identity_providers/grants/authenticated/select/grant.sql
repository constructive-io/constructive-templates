-- Deploy: schemas/myapp_auth_private/tables/identity_providers/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_auth_private/tables/identity_providers/table


GRANT SELECT (slug, kind, display_name, enabled) ON myapp_auth_private.identity_providers TO authenticated;

