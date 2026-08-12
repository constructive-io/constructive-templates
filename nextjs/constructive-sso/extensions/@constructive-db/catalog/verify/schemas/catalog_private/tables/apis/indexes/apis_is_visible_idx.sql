-- Verify: schemas/catalog_private/tables/apis/indexes/apis_is_visible_idx


SELECT assert_index(CAST('catalog_private.apis_is_visible_idx' AS regclass), CAST('catalog_private.apis' AS regclass), false);