-- Deploy: schemas/catalog_private/tables/apps/indexes/apps_owner_scope_owner_key_name_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/table
-- requires: schemas/catalog_private/tables/apps/columns/name/column
-- requires: schemas/catalog_private/tables/apps/columns/owner_key/column
-- requires: schemas/catalog_private/tables/apps/columns/owner_scope/column


CREATE UNIQUE INDEX apps_owner_scope_owner_key_name_idx ON catalog_private.apps (owner_scope, owner_key, name) WHERE apps.owner_key IS NOT NULL;