-- Deploy: schemas/catalog_public/tables/apis/columns/database_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/apis/table
-- requires: schemas/catalog_public/tables/apis/columns/database_id/column


ALTER TABLE catalog_public.apis 
  ALTER COLUMN database_id SET NOT NULL;