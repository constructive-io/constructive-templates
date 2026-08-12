-- Verify: schemas/catalog_private/tables/functions/indexes/functions_owner_scope_owner_key_idx


SELECT assert_index(CAST('catalog_private.functions_owner_scope_owner_key_idx' AS regclass), CAST('catalog_private.functions' AS regclass), false);