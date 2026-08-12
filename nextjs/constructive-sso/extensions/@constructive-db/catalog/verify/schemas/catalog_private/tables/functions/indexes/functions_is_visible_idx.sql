-- Verify: schemas/catalog_private/tables/functions/indexes/functions_is_visible_idx


SELECT assert_index(CAST('catalog_private.functions_is_visible_idx' AS regclass), CAST('catalog_private.functions' AS regclass), false);