-- Verify: schemas/catalog_public/tables/namespaces/indexes/namespaces_created_at_idx


SELECT verify_index('catalog_public.namespaces', 'namespaces_created_at_idx');