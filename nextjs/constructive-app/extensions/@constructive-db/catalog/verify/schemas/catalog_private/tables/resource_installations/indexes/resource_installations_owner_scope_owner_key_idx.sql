-- Verify: schemas/catalog_private/tables/resource_installations/indexes/resource_installations_owner_scope_owner_key_idx


SELECT assert_index(CAST('catalog_private.resource_installations_owner_scope_owner_key_idx' AS regclass), CAST('catalog_private.resource_installations' AS regclass), false);