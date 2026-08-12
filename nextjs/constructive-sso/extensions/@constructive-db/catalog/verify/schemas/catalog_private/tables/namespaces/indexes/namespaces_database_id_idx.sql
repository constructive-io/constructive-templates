-- Verify: schemas/catalog_private/tables/namespaces/indexes/namespaces_database_id_idx


SELECT assert_index(CAST('catalog_private.namespaces_database_id_idx' AS regclass), CAST('catalog_private.namespaces' AS regclass), false);