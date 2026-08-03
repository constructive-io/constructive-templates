-- Deploy: schemas/catalog_public/tables/domains/columns/updated_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/domains/table
-- requires: schemas/catalog_public/tables/domains/columns/updated_at/column


ALTER TABLE catalog_public.domains 
  ALTER COLUMN updated_at SET DEFAULT now();