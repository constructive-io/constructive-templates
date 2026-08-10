-- Verify: schemas/myapp_auth_public/tables/principal_entities/table


SELECT assert_table('myapp_auth_public.principal_entities'::regclass, false, NULL);


