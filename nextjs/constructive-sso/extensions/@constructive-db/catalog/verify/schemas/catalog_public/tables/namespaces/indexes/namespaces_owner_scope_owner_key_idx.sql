-- Verify: schemas/catalog_public/tables/namespaces/indexes/namespaces_owner_scope_owner_key_idx


SELECT verify_index('catalog_public.namespaces', 'namespaces_owner_scope_owner_key_idx');