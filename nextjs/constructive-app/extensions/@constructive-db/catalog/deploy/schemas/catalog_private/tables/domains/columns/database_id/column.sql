-- Deploy: schemas/catalog_private/tables/domains/columns/database_id/column
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/domains/table


ALTER TABLE catalog_private.domains 
  ADD COLUMN database_id uuid;