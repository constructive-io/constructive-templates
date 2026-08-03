-- Deploy: schemas/myapp_auth_public/views/identity_providers/grants/authenticated/SELECT/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/views/identity_providers/view


GRANT SELECT ON myapp_auth_public.identity_providers TO authenticated;

