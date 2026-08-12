-- Deploy: schemas/myapp_auth_public/views/org_api_key_list/grants/authenticated/SELECT/grant
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/views/org_api_key_list/view


GRANT SELECT ON myapp_auth_public.org_api_key_list TO authenticated;

