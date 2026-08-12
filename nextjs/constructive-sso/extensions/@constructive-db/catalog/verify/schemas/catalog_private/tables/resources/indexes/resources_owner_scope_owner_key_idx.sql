-- Verify: schemas/catalog_private/tables/resources/indexes/resources_owner_scope_owner_key_idx


SELECT assert_index(CAST('catalog_private.resources_owner_scope_owner_key_idx' AS regclass), CAST('catalog_private.resources' AS regclass), false);