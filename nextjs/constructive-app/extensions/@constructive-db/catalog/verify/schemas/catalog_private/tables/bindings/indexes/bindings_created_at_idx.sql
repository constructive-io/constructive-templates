-- Verify: schemas/catalog_private/tables/bindings/indexes/bindings_created_at_idx


SELECT assert_index(CAST('catalog_private.bindings_created_at_idx' AS regclass), CAST('catalog_private.bindings' AS regclass), false);