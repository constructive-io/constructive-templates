-- Deploy: schemas/catalog_public/tables/apps/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apps/table
-- requires: schemas/catalog_public/tables/apps/columns/name/column


ALTER TABLE catalog_public.apps 
  ALTER COLUMN name SET NOT NULL;