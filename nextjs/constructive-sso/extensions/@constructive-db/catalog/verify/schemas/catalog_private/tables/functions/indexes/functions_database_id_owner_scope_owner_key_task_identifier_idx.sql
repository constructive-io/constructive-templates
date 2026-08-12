-- Verify: schemas/catalog_private/tables/functions/indexes/functions_database_id_owner_scope_owner_key_task_identifier_idx


SELECT assert_index(CAST('catalog_private.functions_database_id_owner_scope_owner_key_task_identifier_idx' AS regclass), CAST('catalog_private.functions' AS regclass), true);