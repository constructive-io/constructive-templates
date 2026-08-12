-- Deploy: schemas/catalog_public/tables/apis/columns/owner_scope/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apis/table
-- requires: schemas/catalog_public/tables/apis/columns/owner_scope/column


ALTER TABLE catalog_public.apis 
  ALTER COLUMN owner_scope SET NOT NULL;