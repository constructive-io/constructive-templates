-- Verify: schemas/catalog_public/tables/apis/indexes/apis_created_at_idx


SELECT verify_index('catalog_public.apis', 'apis_created_at_idx');