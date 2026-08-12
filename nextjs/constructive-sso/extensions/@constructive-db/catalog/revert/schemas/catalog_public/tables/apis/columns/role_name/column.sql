-- Revert: schemas/catalog_public/tables/apis/columns/role_name/column


ALTER TABLE catalog_public.apis 
  DROP COLUMN role_name RESTRICT;