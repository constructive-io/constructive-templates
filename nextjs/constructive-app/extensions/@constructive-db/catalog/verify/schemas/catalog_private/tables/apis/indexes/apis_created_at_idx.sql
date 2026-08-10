-- Verify: schemas/catalog_private/tables/apis/indexes/apis_created_at_idx


SELECT assert_index(CAST('catalog_private.apis_created_at_idx' AS regclass), CAST('catalog_private.apis' AS regclass), false);