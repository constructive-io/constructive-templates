-- Verify: schemas/catalog_private/tables/namespaces/indexes/namespaces_updated_at_idx


SELECT assert_index(CAST('catalog_private.namespaces_updated_at_idx' AS regclass), CAST('catalog_private.namespaces' AS regclass), false);