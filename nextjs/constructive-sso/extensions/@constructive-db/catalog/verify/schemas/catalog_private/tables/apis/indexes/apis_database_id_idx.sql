-- Verify: schemas/catalog_private/tables/apis/indexes/apis_database_id_idx


SELECT assert_index(CAST('catalog_private.apis_database_id_idx' AS regclass), CAST('catalog_private.apis' AS regclass), false);