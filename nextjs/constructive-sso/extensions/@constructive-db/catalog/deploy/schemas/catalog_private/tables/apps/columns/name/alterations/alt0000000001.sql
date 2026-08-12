-- Deploy: schemas/catalog_private/tables/apps/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/table
-- requires: schemas/catalog_private/tables/apps/columns/name/column


ALTER TABLE catalog_private.apps 
  ALTER COLUMN name SET NOT NULL;