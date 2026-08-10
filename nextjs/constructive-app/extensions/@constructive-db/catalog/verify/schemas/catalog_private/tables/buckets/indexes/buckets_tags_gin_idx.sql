-- Verify: schemas/catalog_private/tables/buckets/indexes/buckets_tags_gin_idx


SELECT assert_index(CAST('catalog_private.buckets_tags_gin_idx' AS regclass), CAST('catalog_private.buckets' AS regclass), false);