-- Verify: schemas/myapp_auth_public/tables/principal_scope_overrides/table


SELECT assert_table('myapp_auth_public.principal_scope_overrides'::regclass, false, NULL);


