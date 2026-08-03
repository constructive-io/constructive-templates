-- Revert: schemas/myapp_auth_public/tables/principals/columns/is_read_only/column


ALTER TABLE myapp_auth_public.principals 
  DROP COLUMN is_read_only RESTRICT;


