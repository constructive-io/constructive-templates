-- Verify: schemas/myapp_auth_public/views/identity_providers/grants/authenticated/SELECT/grant


SELECT verify_table_grant('myapp_auth_public.identity_providers', 'SELECT', 'authenticated');


