-- Verify: schemas/catalog_private/tables/resource_installations/indexes/resource_installations_created_at_idx


SELECT assert_index(CAST('catalog_private.resource_installations_created_at_idx' AS regclass), CAST('catalog_private.resource_installations' AS regclass), false);