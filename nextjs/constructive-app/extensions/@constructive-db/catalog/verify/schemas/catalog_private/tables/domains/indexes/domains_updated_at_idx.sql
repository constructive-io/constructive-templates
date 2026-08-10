-- Verify: schemas/catalog_private/tables/domains/indexes/domains_updated_at_idx


SELECT assert_index(CAST('catalog_private.domains_updated_at_idx' AS regclass), CAST('catalog_private.domains' AS regclass), false);