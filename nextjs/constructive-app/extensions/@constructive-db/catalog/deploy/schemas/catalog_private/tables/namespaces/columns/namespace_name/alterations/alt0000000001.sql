-- Deploy: schemas/catalog_private/tables/namespaces/columns/namespace_name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/namespaces/table
-- requires: schemas/catalog_private/tables/namespaces/columns/namespace_name/column


ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN namespace_name SET NOT NULL;