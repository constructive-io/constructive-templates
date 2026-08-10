-- Verify: schemas/myapp_auth_private/tables/identity_providers/table


SELECT assert_table('myapp_auth_private.identity_providers'::regclass, false, NULL);


