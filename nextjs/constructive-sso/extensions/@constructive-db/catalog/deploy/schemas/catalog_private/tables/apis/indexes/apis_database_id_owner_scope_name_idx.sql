-- Deploy: schemas/catalog_private/tables/apis/indexes/apis_database_id_owner_scope_name_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apis/table
-- requires: schemas/catalog_private/tables/apis/columns/name/column
-- requires: schemas/catalog_private/tables/apis/columns/owner_key/column
-- requires: schemas/catalog_private/tables/apis/columns/database_id/column
-- requires: schemas/catalog_private/tables/apis/columns/owner_scope/column


CREATE UNIQUE INDEX apis_database_id_owner_scope_name_idx ON catalog_private.apis (database_id, owner_scope, name) WHERE apis.owner_key IS NULL;