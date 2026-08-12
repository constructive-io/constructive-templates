-- Verify: schemas/catalog_public/tables/apis/indexes/apis_owner_scope_name_idx


SELECT verify_index('catalog_public.apis', 'apis_owner_scope_name_idx');