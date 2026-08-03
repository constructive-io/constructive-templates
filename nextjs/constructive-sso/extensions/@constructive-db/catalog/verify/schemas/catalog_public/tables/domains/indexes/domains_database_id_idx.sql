-- Verify: schemas/catalog_public/tables/domains/indexes/domains_database_id_idx


SELECT verify_index('catalog_public.domains', 'domains_database_id_idx');