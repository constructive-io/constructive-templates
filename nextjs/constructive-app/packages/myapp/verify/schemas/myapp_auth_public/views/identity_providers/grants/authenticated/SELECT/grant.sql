-- Verify: schemas/myapp_auth_public/views/identity_providers/grants/authenticated/SELECT/grant


SELECT assert_table_grant('myapp_auth_public.identity_providers'::regclass, 'authenticated', 'SELECT', NULL, true);


