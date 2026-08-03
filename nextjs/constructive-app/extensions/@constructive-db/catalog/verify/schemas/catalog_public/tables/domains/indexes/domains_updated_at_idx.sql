-- Verify: schemas/catalog_public/tables/domains/indexes/domains_updated_at_idx


SELECT verify_index('catalog_public.domains', 'domains_updated_at_idx');