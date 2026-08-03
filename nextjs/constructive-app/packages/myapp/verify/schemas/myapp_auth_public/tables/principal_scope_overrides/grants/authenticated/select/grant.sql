-- Verify: schemas/myapp_auth_public/tables/principal_scope_overrides/grants/authenticated/select/grant


SELECT verify_table_grant('myapp_auth_public.principal_scope_overrides', 'SELECT', 'authenticated');


