-- Deploy: schemas/catalog_private/tables/apis/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apis/table
-- requires: schemas/catalog_private/tables/apis/columns/name/column


ALTER TABLE catalog_private.apis 
  ALTER COLUMN name SET NOT NULL;