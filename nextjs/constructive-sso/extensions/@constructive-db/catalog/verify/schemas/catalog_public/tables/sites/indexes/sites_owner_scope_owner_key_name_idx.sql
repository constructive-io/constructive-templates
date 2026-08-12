-- Verify: schemas/catalog_public/tables/sites/indexes/sites_owner_scope_owner_key_name_idx


SELECT verify_index('catalog_public.sites', 'sites_owner_scope_owner_key_name_idx');