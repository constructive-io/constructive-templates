-- Verify: schemas/catalog_public/tables/buckets/indexes/buckets_database_id_idx


SELECT verify_index('catalog_public.buckets', 'buckets_database_id_idx');