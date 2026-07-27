-- Verify: schemas/myapp_store_private/tables/app_internal_secrets/indexes/app_internal_secrets_created_at_idx


SELECT verify_index('myapp_store_private.app_internal_secrets', 'app_internal_secrets_created_at_idx');


