-- Verify: schemas/catalog_public/tables/domains/indexes/domains_parent_hostname_is_wildcard_idx


SELECT verify_index('catalog_public.domains', 'domains_parent_hostname_is_wildcard_idx');