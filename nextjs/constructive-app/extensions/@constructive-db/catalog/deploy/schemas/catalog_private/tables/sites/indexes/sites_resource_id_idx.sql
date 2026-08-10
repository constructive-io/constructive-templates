-- Deploy: schemas/catalog_private/tables/sites/indexes/sites_resource_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/table
-- requires: schemas/catalog_private/tables/sites/columns/resource_id/column


CREATE INDEX sites_resource_id_idx ON catalog_private.sites (resource_id);