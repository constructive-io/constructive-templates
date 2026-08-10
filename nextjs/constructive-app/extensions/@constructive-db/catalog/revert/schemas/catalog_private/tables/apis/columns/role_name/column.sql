-- Revert: schemas/catalog_private/tables/apis/columns/role_name/column


ALTER TABLE catalog_private.apis 
  DROP COLUMN role_name RESTRICT;