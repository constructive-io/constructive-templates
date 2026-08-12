-- Revert: schemas/catalog_private/tables/apis/columns/anon_role/column


ALTER TABLE catalog_private.apis 
  DROP COLUMN anon_role RESTRICT;