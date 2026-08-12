-- Deploy: schemas/catalog_private/tables/apps/indexes/apps_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/table
-- requires: schemas/catalog_private/tables/apps/columns/updated_at/column


CREATE INDEX apps_updated_at_idx ON catalog_private.apps (updated_at);