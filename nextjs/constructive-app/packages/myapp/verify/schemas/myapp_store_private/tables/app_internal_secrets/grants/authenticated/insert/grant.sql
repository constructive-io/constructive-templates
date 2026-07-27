-- Verify: schemas/myapp_store_private/tables/app_internal_secrets/grants/authenticated/insert/grant


SELECT verify_table_grant('myapp_store_private.app_internal_secrets', 'insert', 'authenticated');


