-- Verify: schemas/catalog_private/tables/apps/indexes/apps_database_id_idx


SELECT assert_index(CAST('catalog_private.apps_database_id_idx' AS regclass), CAST('catalog_private.apps' AS regclass), false);