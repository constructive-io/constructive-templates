-- Deploy: schemas/catalog_private/tables/sites_web_config/columns/database_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_web_config/table
-- requires: schemas/catalog_private/tables/sites_web_config/columns/database_id/column


ALTER TABLE catalog_private.sites_web_config 
  ALTER COLUMN database_id SET NOT NULL;