-- Verify: schemas/myapp_auth_public/tables/principal_scope_overrides/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_auth_public.principal_scope_overrides'::regclass, 'authenticated', 'SELECT', NULL, true);


