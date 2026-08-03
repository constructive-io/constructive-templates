-- Verify: schemas/myapp_auth_private/tables/identity_providers/grants/authenticated/delete/grant


SELECT verify_table_grant('myapp_auth_private.identity_providers', 'DELETE', 'authenticated');


