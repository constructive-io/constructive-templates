-- Verify: schemas/myapp_auth_private/tables/identity_providers/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_auth_private.identity_providers'::regclass, 'authenticated', 'SELECT', ARRAY['slug', 'kind', 'display_name', 'enabled'], true);


