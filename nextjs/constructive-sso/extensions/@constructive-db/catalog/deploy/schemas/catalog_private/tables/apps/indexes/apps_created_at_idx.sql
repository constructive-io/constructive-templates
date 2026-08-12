-- Deploy: schemas/catalog_private/tables/apps/indexes/apps_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/table
-- requires: schemas/catalog_private/tables/apps/columns/created_at/column


CREATE INDEX apps_created_at_idx ON catalog_private.apps (created_at);