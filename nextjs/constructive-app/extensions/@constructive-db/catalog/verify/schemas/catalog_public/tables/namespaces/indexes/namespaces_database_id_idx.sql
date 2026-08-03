-- Verify: schemas/catalog_public/tables/namespaces/indexes/namespaces_database_id_idx


SELECT verify_index('catalog_public.namespaces', 'namespaces_database_id_idx');