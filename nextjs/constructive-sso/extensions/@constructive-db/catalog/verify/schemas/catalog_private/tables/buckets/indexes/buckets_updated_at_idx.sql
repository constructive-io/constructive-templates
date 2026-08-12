-- Verify: schemas/catalog_private/tables/buckets/indexes/buckets_updated_at_idx


SELECT assert_index(CAST('catalog_private.buckets_updated_at_idx' AS regclass), CAST('catalog_private.buckets' AS regclass), false);