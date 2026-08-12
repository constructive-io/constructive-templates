-- Verify: schemas/catalog_private/tables/resources/indexes/resources_updated_at_idx


SELECT assert_index(CAST('catalog_private.resources_updated_at_idx' AS regclass), CAST('catalog_private.resources' AS regclass), false);