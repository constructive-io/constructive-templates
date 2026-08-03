-- Revert: schemas/myapp_auth_public/tables/principals/columns/name/column


ALTER TABLE myapp_auth_public.principals 
  DROP COLUMN name RESTRICT;


