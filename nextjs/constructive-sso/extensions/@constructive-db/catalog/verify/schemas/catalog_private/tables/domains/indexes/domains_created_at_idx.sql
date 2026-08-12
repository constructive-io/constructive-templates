-- Verify: schemas/catalog_private/tables/domains/indexes/domains_created_at_idx


SELECT assert_index(CAST('catalog_private.domains_created_at_idx' AS regclass), CAST('catalog_private.domains' AS regclass), false);