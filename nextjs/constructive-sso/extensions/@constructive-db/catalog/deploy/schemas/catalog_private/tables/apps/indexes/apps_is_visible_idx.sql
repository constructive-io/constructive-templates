-- Deploy: schemas/catalog_private/tables/apps/indexes/apps_is_visible_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/table
-- requires: schemas/catalog_private/tables/apps/columns/is_visible/column


CREATE INDEX apps_is_visible_idx ON catalog_private.apps (is_visible);