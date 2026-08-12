-- Verify: schemas/myapp_store_private/tables/app_internal_secrets/indexes/app_internal_secrets_namespace_id_name_realm_idx


SELECT assert_index('myapp_store_private.app_internal_secrets_namespace_id_name_realm_idx'::regclass, 'myapp_store_private.app_internal_secrets'::regclass, true);


