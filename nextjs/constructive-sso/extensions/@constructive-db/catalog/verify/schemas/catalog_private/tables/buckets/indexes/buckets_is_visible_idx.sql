-- Verify: schemas/catalog_private/tables/buckets/indexes/buckets_is_visible_idx


SELECT assert_index(CAST('catalog_private.buckets_is_visible_idx' AS regclass), CAST('catalog_private.buckets' AS regclass), false);