-- Deploy: schemas/catalog_private/tables/sites/indexes/sites_is_visible_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/table
-- requires: schemas/catalog_private/tables/sites/columns/is_visible/column


CREATE INDEX sites_is_visible_idx ON catalog_private.sites (is_visible);