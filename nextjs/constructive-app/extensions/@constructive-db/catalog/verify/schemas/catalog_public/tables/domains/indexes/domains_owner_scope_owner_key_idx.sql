-- Verify: schemas/catalog_public/tables/domains/indexes/domains_owner_scope_owner_key_idx


SELECT verify_index('catalog_public.domains', 'domains_owner_scope_owner_key_idx');