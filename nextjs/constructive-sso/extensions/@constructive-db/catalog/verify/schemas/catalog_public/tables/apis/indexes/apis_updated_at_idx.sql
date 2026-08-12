-- Verify: schemas/catalog_public/tables/apis/indexes/apis_updated_at_idx


SELECT verify_index('catalog_public.apis', 'apis_updated_at_idx');