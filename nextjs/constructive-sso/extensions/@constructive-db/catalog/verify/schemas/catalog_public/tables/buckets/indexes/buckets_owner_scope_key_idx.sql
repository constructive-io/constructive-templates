-- Verify: schemas/catalog_public/tables/buckets/indexes/buckets_owner_scope_key_idx


SELECT verify_index('catalog_public.buckets', 'buckets_owner_scope_key_idx');