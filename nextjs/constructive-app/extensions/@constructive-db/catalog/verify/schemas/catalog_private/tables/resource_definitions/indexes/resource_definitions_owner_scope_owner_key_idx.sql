-- Verify: schemas/catalog_private/tables/resource_definitions/indexes/resource_definitions_owner_scope_owner_key_idx


SELECT assert_index(CAST('catalog_private.resource_definitions_owner_scope_owner_key_idx' AS regclass), CAST('catalog_private.resource_definitions' AS regclass), false);