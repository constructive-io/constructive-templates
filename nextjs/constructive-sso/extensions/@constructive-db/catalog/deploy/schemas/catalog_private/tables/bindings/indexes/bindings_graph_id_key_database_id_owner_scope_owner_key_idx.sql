-- Deploy: schemas/catalog_private/tables/bindings/indexes/bindings_graph_id_key_database_id_owner_scope_owner_key_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/bindings/table
-- requires: schemas/catalog_private/tables/bindings/columns/key/column
-- requires: schemas/catalog_private/tables/bindings/columns/graph_id/column
-- requires: schemas/catalog_private/tables/bindings/columns/owner_key/column
-- requires: schemas/catalog_private/tables/bindings/columns/database_id/column
-- requires: schemas/catalog_private/tables/bindings/columns/owner_scope/column


CREATE INDEX bindings_graph_id_key_database_id_owner_scope_owner_key_idx ON catalog_private.bindings (graph_id, key, database_id, owner_scope, owner_key);