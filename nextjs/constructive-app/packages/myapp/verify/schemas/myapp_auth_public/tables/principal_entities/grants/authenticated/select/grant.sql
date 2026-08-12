-- Verify: schemas/myapp_auth_public/tables/principal_entities/grants/authenticated/select/grant


SELECT assert_table_grant('myapp_auth_public.principal_entities'::regclass, 'authenticated', 'SELECT', NULL, true);


