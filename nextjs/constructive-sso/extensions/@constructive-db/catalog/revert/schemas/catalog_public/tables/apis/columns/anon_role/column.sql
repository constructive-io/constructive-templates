-- Revert: schemas/catalog_public/tables/apis/columns/anon_role/column


ALTER TABLE catalog_public.apis 
  DROP COLUMN anon_role RESTRICT;