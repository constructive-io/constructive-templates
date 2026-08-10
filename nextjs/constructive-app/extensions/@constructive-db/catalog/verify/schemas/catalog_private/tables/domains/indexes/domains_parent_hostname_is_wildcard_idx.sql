-- Verify: schemas/catalog_private/tables/domains/indexes/domains_parent_hostname_is_wildcard_idx


SELECT assert_index(CAST('catalog_private.domains_parent_hostname_is_wildcard_idx' AS regclass), CAST('catalog_private.domains' AS regclass), false);