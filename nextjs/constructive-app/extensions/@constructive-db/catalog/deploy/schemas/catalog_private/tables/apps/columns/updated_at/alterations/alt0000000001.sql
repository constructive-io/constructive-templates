-- Deploy: schemas/catalog_private/tables/apps/columns/updated_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/table
-- requires: schemas/catalog_private/tables/apps/columns/updated_at/column


ALTER TABLE catalog_private.apps 
  ALTER COLUMN updated_at SET DEFAULT now();