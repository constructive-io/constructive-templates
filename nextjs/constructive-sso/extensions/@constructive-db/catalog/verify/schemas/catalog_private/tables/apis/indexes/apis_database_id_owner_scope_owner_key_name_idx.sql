-- Verify: schemas/catalog_private/tables/apis/indexes/apis_database_id_owner_scope_owner_key_name_idx


SELECT assert_index(CAST('catalog_private.apis_database_id_owner_scope_owner_key_name_idx' AS regclass), CAST('catalog_private.apis' AS regclass), true);