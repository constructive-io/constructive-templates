-- Deploy: schemas/catalog_public/tables/namespaces/columns/namespace_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/namespaces/table
-- requires: schemas/catalog_public/tables/namespaces/columns/namespace_name/column


ALTER TABLE catalog_public.namespaces 
  ALTER COLUMN namespace_name SET NOT NULL;