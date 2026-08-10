-- Verify: schemas/catalog_private/tables/apps/indexes/apps_owner_scope_name_idx


SELECT assert_index(CAST('catalog_private.apps_owner_scope_name_idx' AS regclass), CAST('catalog_private.apps' AS regclass), true);