-- Verify: schemas/catalog_private/tables/functions/indexes/functions_updated_at_idx


SELECT assert_index(CAST('catalog_private.functions_updated_at_idx' AS regclass), CAST('catalog_private.functions' AS regclass), false);