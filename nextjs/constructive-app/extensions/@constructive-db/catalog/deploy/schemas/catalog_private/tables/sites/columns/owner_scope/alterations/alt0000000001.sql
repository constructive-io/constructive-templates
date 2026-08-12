-- Deploy: schemas/catalog_private/tables/sites/columns/owner_scope/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites/table
-- requires: schemas/catalog_private/tables/sites/columns/owner_scope/column


ALTER TABLE catalog_private.sites 
  ALTER COLUMN owner_scope SET NOT NULL;