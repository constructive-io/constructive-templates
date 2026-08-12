-- Deploy: schemas/catalog_private/tables/resources/columns/namespace_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/resources/table
-- requires: schemas/catalog_private/tables/resources/columns/namespace_id/column


ALTER TABLE catalog_private.resources 
  ALTER COLUMN namespace_id SET NOT NULL;