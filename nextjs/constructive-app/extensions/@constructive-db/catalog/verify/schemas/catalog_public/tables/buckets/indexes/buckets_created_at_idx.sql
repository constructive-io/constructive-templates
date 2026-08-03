-- Verify: schemas/catalog_public/tables/buckets/indexes/buckets_created_at_idx


SELECT verify_index('catalog_public.buckets', 'buckets_created_at_idx');