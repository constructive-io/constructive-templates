-- Verify: schemas/catalog_private/tables/sites/indexes/sites_owner_scope_name_idx


SELECT assert_index(CAST('catalog_private.sites_owner_scope_name_idx' AS regclass), CAST('catalog_private.sites' AS regclass), true);