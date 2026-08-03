-- Verify: schemas/myapp_auth_public/tables/principal_entities/grants/authenticated/select/grant


SELECT verify_table_grant('myapp_auth_public.principal_entities', 'SELECT', 'authenticated');


