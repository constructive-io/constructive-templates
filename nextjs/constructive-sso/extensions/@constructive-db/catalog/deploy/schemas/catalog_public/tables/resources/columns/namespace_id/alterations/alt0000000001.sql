-- Deploy: schemas/catalog_public/tables/resources/columns/namespace_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/resources/table
-- requires: schemas/catalog_public/tables/resources/columns/namespace_id/column


ALTER TABLE catalog_public.resources 
  ALTER COLUMN namespace_id SET NOT NULL;