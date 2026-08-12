-- Deploy: schemas/catalog_public/tables/apps/indexes/apps_is_visible_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apps/table
-- requires: schemas/catalog_public/tables/apps/columns/is_visible/column


CREATE INDEX apps_is_visible_idx ON catalog_public.apps (is_visible);