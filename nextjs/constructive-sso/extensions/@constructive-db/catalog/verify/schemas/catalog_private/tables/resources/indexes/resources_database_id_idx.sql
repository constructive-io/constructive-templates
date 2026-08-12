-- Verify: schemas/catalog_private/tables/resources/indexes/resources_database_id_idx


SELECT assert_index(CAST('catalog_private.resources_database_id_idx' AS regclass), CAST('catalog_private.resources' AS regclass), false);