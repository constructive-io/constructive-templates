-- Deploy: schemas/catalog_private/tables/namespaces/columns/updated_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/namespaces/table
-- requires: schemas/catalog_private/tables/namespaces/columns/updated_at/column


ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN updated_at SET DEFAULT now();