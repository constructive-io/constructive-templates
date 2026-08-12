-- Verify: schemas/catalog_private/tables/domains/indexes/domains_owner_scope_owner_key_idx


SELECT assert_index(CAST('catalog_private.domains_owner_scope_owner_key_idx' AS regclass), CAST('catalog_private.domains' AS regclass), false);