-- Verify: schemas/catalog_private/tables/buckets/indexes/buckets_owner_scope_owner_key_idx


SELECT assert_index(CAST('catalog_private.buckets_owner_scope_owner_key_idx' AS regclass), CAST('catalog_private.buckets' AS regclass), false);