-- Revert: schemas/myapp_auth_public/tables/principals/columns/use_admin_owner/column


ALTER TABLE myapp_auth_public.principals 
  DROP COLUMN use_admin_owner RESTRICT;


