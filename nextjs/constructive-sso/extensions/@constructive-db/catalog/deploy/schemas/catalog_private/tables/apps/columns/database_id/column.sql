-- Deploy: schemas/catalog_private/tables/apps/columns/database_id/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/apps/table


ALTER TABLE catalog_private.apps 
  ADD COLUMN database_id uuid;