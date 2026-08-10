-- Verify: schemas/catalog_private/tables/namespaces/indexes/namespaces_owner_scope_owner_key_idx


SELECT assert_index(CAST('catalog_private.namespaces_owner_scope_owner_key_idx' AS regclass), CAST('catalog_private.namespaces' AS regclass), false);