-- Verify: schemas/catalog_private/tables/resource_definitions/indexes/resource_definitions_database_id_idx


SELECT assert_index(CAST('catalog_private.resource_definitions_database_id_idx' AS regclass), CAST('catalog_private.resource_definitions' AS regclass), false);