-- Verify: schemas/catalog_public/tables/buckets/indexes/buckets_is_visible_idx


SELECT verify_index('catalog_public.buckets', 'buckets_is_visible_idx');