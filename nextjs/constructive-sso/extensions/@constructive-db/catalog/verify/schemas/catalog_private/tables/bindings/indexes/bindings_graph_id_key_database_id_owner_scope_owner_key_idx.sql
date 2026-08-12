-- Verify: schemas/catalog_private/tables/bindings/indexes/bindings_graph_id_key_database_id_owner_scope_owner_key_idx


SELECT assert_index(CAST('catalog_private.bindings_graph_id_key_database_id_owner_scope_owner_key_idx' AS regclass), CAST('catalog_private.bindings' AS regclass), false);