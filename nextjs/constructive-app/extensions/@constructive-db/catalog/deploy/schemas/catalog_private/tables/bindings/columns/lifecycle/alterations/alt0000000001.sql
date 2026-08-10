-- Deploy: schemas/catalog_private/tables/bindings/columns/lifecycle/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/bindings/table
-- requires: schemas/catalog_private/tables/bindings/columns/lifecycle/column


ALTER TABLE catalog_private.bindings 
  ALTER COLUMN lifecycle SET NOT NULL;