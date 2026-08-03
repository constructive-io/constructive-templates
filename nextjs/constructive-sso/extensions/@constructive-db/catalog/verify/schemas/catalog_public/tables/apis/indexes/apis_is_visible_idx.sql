-- Verify: schemas/catalog_public/tables/apis/indexes/apis_is_visible_idx


SELECT verify_index('catalog_public.apis', 'apis_is_visible_idx');