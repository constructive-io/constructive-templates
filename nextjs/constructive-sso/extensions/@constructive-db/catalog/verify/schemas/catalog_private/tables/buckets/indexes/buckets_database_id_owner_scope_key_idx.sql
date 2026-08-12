-- Verify: schemas/catalog_private/tables/buckets/indexes/buckets_database_id_owner_scope_key_idx


SELECT assert_index(CAST('catalog_private.buckets_database_id_owner_scope_key_idx' AS regclass), CAST('catalog_private.buckets' AS regclass), true);