-- Deploy: schemas/catalog_private/tables/sites_error_pages/indexes/sites_error_pages_site_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_error_pages/table
-- requires: schemas/catalog_private/tables/sites_error_pages/columns/site_id/column


CREATE INDEX sites_error_pages_site_id_idx ON catalog_private.sites_error_pages (site_id);