-- Verify: schemas/catalog_public/tables/resources/indexes/resources_owner_scope_owner_key_idx


SELECT verify_index('catalog_public.resources', 'resources_owner_scope_owner_key_idx');