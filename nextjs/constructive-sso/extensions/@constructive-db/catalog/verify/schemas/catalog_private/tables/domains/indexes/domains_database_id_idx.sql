-- Verify: schemas/catalog_private/tables/domains/indexes/domains_database_id_idx


SELECT assert_index(CAST('catalog_private.domains_database_id_idx' AS regclass), CAST('catalog_private.domains' AS regclass), false);