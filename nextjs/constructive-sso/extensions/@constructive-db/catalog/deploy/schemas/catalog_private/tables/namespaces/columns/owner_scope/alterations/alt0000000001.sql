-- Deploy: schemas/catalog_private/tables/namespaces/columns/owner_scope/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/namespaces/table
-- requires: schemas/catalog_private/tables/namespaces/columns/owner_scope/column


ALTER TABLE catalog_private.namespaces 
  ALTER COLUMN owner_scope SET NOT NULL;