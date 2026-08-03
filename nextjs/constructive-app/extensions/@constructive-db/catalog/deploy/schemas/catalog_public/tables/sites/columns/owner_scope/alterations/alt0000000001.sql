-- Deploy: schemas/catalog_public/tables/sites/columns/owner_scope/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/sites/table
-- requires: schemas/catalog_public/tables/sites/columns/owner_scope/column


ALTER TABLE catalog_public.sites 
  ALTER COLUMN owner_scope SET NOT NULL;