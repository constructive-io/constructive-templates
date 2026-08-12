-- Deploy: schemas/catalog_public/tables/sites/indexes/sites_is_visible_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/sites/table
-- requires: schemas/catalog_public/tables/sites/columns/is_visible/column


CREATE INDEX sites_is_visible_idx ON catalog_public.sites (is_visible);