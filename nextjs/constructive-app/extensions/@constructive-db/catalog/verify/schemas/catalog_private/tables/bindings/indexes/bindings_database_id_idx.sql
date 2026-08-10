-- Verify: schemas/catalog_private/tables/bindings/indexes/bindings_database_id_idx


SELECT assert_index(CAST('catalog_private.bindings_database_id_idx' AS regclass), CAST('catalog_private.bindings' AS regclass), false);