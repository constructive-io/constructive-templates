-- Deploy: schemas/catalog_private/tables/sites/indexes/sites_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/table
-- requires: schemas/catalog_private/tables/sites/columns/created_at/column


CREATE INDEX sites_created_at_idx ON catalog_private.sites (created_at);