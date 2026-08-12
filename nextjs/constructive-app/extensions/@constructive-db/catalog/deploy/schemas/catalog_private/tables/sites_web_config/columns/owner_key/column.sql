-- Deploy: schemas/catalog_private/tables/sites_web_config/columns/owner_key/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_web_config/table


ALTER TABLE catalog_private.sites_web_config 
  ADD COLUMN owner_key uuid;