-- Verify: schemas/catalog_public/tables/apis/indexes/apis_database_id_idx


SELECT verify_index('catalog_public.apis', 'apis_database_id_idx');