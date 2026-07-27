-- Verify: schemas/myapp_auth_private/tables/identity_providers/grants/authenticated/select/grant


SELECT verify_table_grant('myapp_auth_private.identity_providers', 'select', 'authenticated');


